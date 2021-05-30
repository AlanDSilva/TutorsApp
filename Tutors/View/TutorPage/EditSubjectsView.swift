//
//  EditSubjectsView.swift
//  Tutors
//
//  Created by Alan on 30.5.2021.
//

import SwiftUI

struct EditSubjectsView: View {
    //MARK: - properties
    @State var subjects: [String] = ["Finnish", "English", "Portuguese"]
    
    //MARK: - body
    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            ForEach(subjects, id: \.self) { subject in
                HStack {
                    Text(subject)
                    Spacer()
                }
            }
            
            Button(action: {}, label: {
                Text("Save")
            })
        }
    }
}

struct EditSubjectsView_Previews: PreviewProvider {
    static var previews: some View {
        EditSubjectsView()
    }
}
