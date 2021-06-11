//
//  EditDescriptionView.swift
//  Tutors
//
//  Created by Alan on 30.5.2021.
//

import SwiftUI

struct EditDescriptionView: View {
    //MARK: - properties
    @State var description: String
    @ObservedObject var tutorVM: TutorPageViewModel
    
    //MARK: - body
    var body: some View {
        VStack(spacing: 20) {
            Text("Description")
                .font(.title)
            
            TextEditor(text: $description)
                .foregroundColor(Color.gray)
                .font(.custom("HelveticaNeue", size: 13))
                .frame(height: 300)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 25).stroke())
            
            
            Button(action: {
                tutorVM.updateDescription(with: description)
            }, label: {
                Text("Save")
            })
        }
        .padding()
    }
}

//struct EditDescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditDescriptionView(description: .constant(""))
//    }
//}
