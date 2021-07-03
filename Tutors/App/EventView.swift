//
//  EventView.swift
//  Tutors
//
//  Created by Alan on 18.6.2021.
//

import SwiftUI



struct EventView: View {
    @ObservedObject var messageListVM: MessageListViewModel
    @State private var selectedTab: Int = 0
    @State private var selectedRole : Role = Role.teacher
    @State private var date = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    let positions = ["Role", "Date", "Time", "Confirm"]
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<positions.count) { index in
                    Button(action: {selectedTab = index}, label: {
                        ProgressItem(text: positions[index], index: index, data: getData(of: index))
                            .foregroundColor(selectedTab == index ? colorPink : Color.black)
                    })
                    Text(">")
                }
            }
            TabView(selection: $selectedTab) {
                RolePickerView(selectedRole: $selectedRole).tag(0)
                
                DatePickerView(date: $date).tag(1)
                
                TimePickerView(startTime: $startTime, endTime: $endTime).tag(2)
                
                VStack {
                    List(0..<positions.count - 1) { index in
                        HStack {
                            Text(positions[index])
                                .font(.footnote)
                            Text(getData(of: index))
                        }
                    }
                }.tag(3)
                
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Button(action: {
                if selectedTab < 3 {
                    selectedTab += 1
                } else {
                    sendInvitation()
                }
            }, label: {
                CustomButtonView(text: selectedTab < 3 ? positions[selectedTab+1]+" >" : "Finish >")
                    .frame(maxHeight: 100)
            })
        }.padding()
    }
    
    func getData(of position: Int) -> String {
        switch(position) {
        case 0: return selectedRole.rawValue
        case 1: return formatDate(date: date)
        case 2: return formatTime(date: startTime) + " to " + formatTime(date: endTime)
        default: return ""
        }
    }
    
    func sendInvitation() {
        var event = Event()
        event.date = formatDate(date: date)
        event.startTime = formatTime(date: startTime)
        event.endTime = formatTime(date: endTime)
        if selectedRole == Role.student {
            event.studentID = messageListVM.messageRepo.userId
        }
        if selectedRole == Role.teacher {
            event.teacherID = messageListVM.messageRepo.userId
        }
        
        print(event)
    }
}

enum Role: String, CaseIterable, Identifiable {
    case teacher
    case student
    
    var id: String { self.rawValue }
}

//struct EventView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventView()
//    }
//}

struct RolePickerView: View {
    @Binding var selectedRole: Role
    var body: some View {
        VStack {
            Text("Selected role: \(selectedRole.rawValue)")
            Picker("Select Role", selection: $selectedRole) {
                Text("Teacher").tag(Role.teacher)
                Text("Student").tag(Role.student)
            }
            
        }
    }
}

struct DatePickerView: View {
    @Binding var date: Date
    var body: some View {
        VStack {
            Text("Selected Date: \(formatDate(date: date))")
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
        }
    }
}

struct TimePickerView: View {
    @Binding var startTime: Date
    @Binding var endTime: Date
    var body: some View {
        VStack {
            DatePicker(
                "Start Time",
                selection: $startTime,
                displayedComponents: [.hourAndMinute]
            )
            DatePicker(
                "End Time",
                selection: $endTime,
                displayedComponents: [.hourAndMinute]
            )
        }
    }
}

struct ProgressItem: View {
    var text: String = "Role"
    var index: Int = 0
    var data: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            ZStack {
                Circle().stroke().frame(width: 15, height: 15)
                Text(String(index))
            }
            Text(data)
        }
        .font(.footnote)
    }
}
