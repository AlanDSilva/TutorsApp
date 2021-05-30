//
//  EditDescriptionView.swift
//  Tutors
//
//  Created by Alan on 30.5.2021.
//

import SwiftUI

struct EditDescriptionView: View {
    //MARK: - properties
    @State var description: String = "This is some editable text"
    //MARK: - body
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Description")
                .font(.title)
            
            TextEditor(text: $description)
                .foregroundColor(Color.gray)
                .font(.custom("HelveticaNeue", size: 13))
                .frame(height: 300)
                .background(Color.red)
                .padding()
            
            
            Button(action: {}, label: {
                Text("Save")
            })
        }
        .padding()
    }
}

struct EditDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        EditDescriptionView()
    }
}
