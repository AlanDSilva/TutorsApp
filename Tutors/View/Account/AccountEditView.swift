//
//  AccountEditView.swift
//  Tutors
//
//  Created by Alan on 25.5.2021.
//

import SwiftUI

struct AccountEditView: View {
    //MARK: - properties
    @State var user: User
    
    //MARK: - body
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            CustomTextField(image: "person", placeholder: "Name", text: $user.name)
        }
        
    }
}

//struct AccountEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountEditView()
//    }
//}
