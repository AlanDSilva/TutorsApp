//
//  EditSubjectsView.swift
//  Tutors
//
//  Created by Alan on 30.5.2021.
//

import SwiftUI

struct EditSubjectsView: View {
    //MARK: - properties
    @Binding var subjects: [String]
    @State var isAddingItem: Bool = false
    
    //MARK: - body
    var body: some View {
        VStack(spacing: 20) {
            Text("Subjects")
                .font(.title)
            List {
                ForEach(subjects, id: \.self) { subject in
                    HStack {
                        Text(subject)
                        Spacer()
                    }
                }
            }//: list
            .listStyle(PlainListStyle())
            .frame(height: 300)
            
            if isAddingItem {
                NewSubjectView(isAddingItem: $isAddingItem)
                    .padding()
            } else {
                Button(action: {isAddingItem.toggle()}, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                })
                .padding(.horizontal)
            }
            
            
        }//: vstack
        
    }
}

struct NewSubjectView: View {
    @Binding var isAddingItem: Bool
    @State var newSubject: String = ""
    var body: some View {
        VStack {
            TextField("Enter new subject", text: $newSubject)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke())
            HStack{
                Button(action: {isAddingItem.toggle()}, label: {
                    Text("Cancel")
                })
                Spacer()
                Button(action: {isAddingItem.toggle()}, label: {
                    Text("Save")
                })
            }//: hstack
            .font(.title2)
        }
            
    }
}

struct EditSubjectsView_Previews: PreviewProvider {
    static var previews: some View {
        EditSubjectsView(subjects: .constant(["English", "Portuguese", "Finnish"]))
    }
}
