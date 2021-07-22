//
//  EventView.swift
//  Tutors
//
//  Created by Alan on 18.6.2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct EventView2: View {
    @ObservedObject var eventVM: EventViewModel
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
                RolePickerView(selectedRole: $selectedRole)
                    .onChange(of: selectedRole, perform: { value in
                        eventVM.changeRole(to: value)
                        print(eventVM.event)
                    })
                    .tag(0)
                
                DatePickerView(date: $date)
                    .onChange(of: date, perform: { value in
                        eventVM.changeDate(to: value)
                        print(eventVM.event)
                    })
                    .tag(1)
                
                TimePickerView(startTime: $startTime, endTime: $endTime)
                    .onChange(of: startTime, perform: { value in
                        eventVM.changeStartTime(to: value)
                        print(eventVM.event)
                    })
                    .onChange(of: endTime, perform: { value in
                        eventVM.changeEndTime(to: value)
                        print(eventVM.event)
                    }).tag(2)
                
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
                    eventVM.sendInvitation()
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
        case 1: return eventVM.event.date
        case 2: return eventVM.event.startTime + " to " + eventVM.event.endTime
        default: return ""
        }
    }
    
}



//struct EventView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventView()
//    }
//}


