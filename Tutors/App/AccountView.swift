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
    @StateObject var userVM = UserViewModel()
    
    //MARK: - body
    var body: some View {
        
        if status {
            AccountDetailView(model: model, userVM: userVM)
                .onAppear {
                    userVM.loadUser()
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
