//
//  AuthViewModel.swift
//  Tutors
//
//  Created by Alan on 24.5.2021.
//

import Foundation
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignup = false
    
    @Published var email_signup = ""
    @Published var password_signup = ""
    @Published var reEnterPassword = ""
    
    @Published var resetEmail = ""
    @Published var isLinkSend = false
    
    @Published var alert = false
    @Published var alertMessage = ""
    
    @Published var isLoading = false
    
    @AppStorage("log_status") var status = false
    
    
    func resetPassword() {
        let alert = UIAlertController(title: "Reset Password", message: "Enter yout e-mail to resert your Password", preferredStyle: .alert)
        alert.addTextField { password in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { _ in
//            self.resetEmail = alert.textFields![0].text!
            
            if alert.textFields![0].text! != "" {
                withAnimation {
                    self.isLoading.toggle()
                }
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { err in
                    withAnimation {
                        self.isLoading.toggle()
                    }
                
                    if err != nil {
                        self.alertMessage = err!.localizedDescription
                        self.alert = true
                        return
                    }
                    
                    self.alertMessage = "Password reset link has been sent"
                    self.alert.toggle()
                }
            }
            
            self.isLinkSend.toggle()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    func login() {
        
        if email == "" || password == ""{
            self.alertMessage = "All fields must be filled!"
            self.alert = true
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMessage = err!.localizedDescription
                self.alert = true
                return
            }
            
            let user = Auth.auth().currentUser
            if !user!.isEmailVerified {
                self.alertMessage = "Please verify your email"
                self.alert = true
                
                try! Auth.auth().signOut()
                return
            }
            
            withAnimation{
                self.status = true
            }
        }
    }
    
    func signup() {
        if email_signup == "" || password_signup == "" || reEnterPassword == ""{
            self.alertMessage = "All fields must be filled!"
            self.alert = true
            return
        }
        
        if password_signup != reEnterPassword {
            self.alertMessage = "Passwords must match"
            self.alert = true
            return
        }
        
        withAnimation {
            self.isLoading.toggle()
        }
        
        Auth.auth().createUser(withEmail: email_signup, password: password_signup) { result, err in
            withAnimation {
                self.isLoading.toggle()
            }
            
            if err != nil {
                self.alertMessage = err!.localizedDescription
                self.alert = true
                return
            }
            
            result?.user.sendEmailVerification(completion: { err in
                if err != nil {
                    self.alertMessage = err!.localizedDescription
                    self.alert = true
                    return
                }
                
                self.alertMessage = "Email Verification has been sent"
                self.alert = true
            })
        }
    }
    
    func logout() {
        try! Auth.auth().signOut()
        
        withAnimation {
            self.status = false
        }
        
        clearData()
    }
    
    func clearData() {
        email = ""
        password = ""
        email_signup = ""
        password_signup = ""
        reEnterPassword = ""
    }
    
    
}
