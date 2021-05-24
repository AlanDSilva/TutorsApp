//
//  AccountView.swift
//  Tutors
//
//  Created by Alan on 17.5.2021.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    //MARK: - properties
    @AppStorage("log_status") var status = false
    @StateObject var model = AuthViewModel()
    
    //MARK: - body
    var body: some View {
        
        if status {
            VStack {
                Text("Logged in as \(Auth.auth().currentUser?.email ?? "")")
                Button(action: {model.logout()}, label: {
                    Text("Logout")
                })
            }
        } else {
            LoginView(model: model)
        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
