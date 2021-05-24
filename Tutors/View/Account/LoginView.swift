//
//  LoginView.swift
//  Tutors
//
//  Created by Alan on 22.5.2021.
//

import SwiftUI

struct LoginView: View {
    //MARK: - properties
//    @State var email: String = ""
//    @State var password: String = ""
//    @State var isFullScreenCover: Bool = false
    @StateObject var model = ModelData()
    
    //MARK: - body
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                CustomTextField(image: "person", placeholder: "Email", text: $model.email)
                CustomTextField(image: "lock", placeholder: "Password", text: $model.password)
            }
            .padding(.top)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                Text("Login")
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .background(colorGray)
                    .clipShape(Capsule())
            }
            .padding(.top, 22)
            
            HStack(spacing: 12) {
                Text("Don't have abd account?")
                
                Button(action: {
                    model.isSignup = true
                }) {
                    Text("Sign up now")
                        .fontWeight(.bold)
                        .foregroundColor(colorGray)
                }
                .padding(.vertical, 22)
            }//: hstack
            
            Button(action: {model.resetPassword()}) {
                Text("Forget password?")
                    .fontWeight(.bold)
            }
        }
        .fullScreenCover(isPresented: $model.isSignup, content: {
            SignupView(model: model)
        })
        .alert(isPresented: $model.isLinkSend, content: {
            Alert(title: Text("Message"), message: Text("Password Reset Link Has Been Sent"), dismissButton: .destructive(Text("OK")))
        })
    }
}

struct CustomTextField: View {
    
    //MARK: - properties
    var image: String
    var placeholder: String
    @Binding var text: String
    
    //MARK: - body
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: image)
                .font(.title2)
                .frame(width: 60, height: 60)
                .background(colorGray)
                .clipShape(Circle())
            
            ZStack {
                if placeholder.contains("Password") {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding(.horizontal)
            .padding(.leading, 65)
            .frame(height: 60)
            .background(Color.white.opacity(0.2))
            .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

//MARK: - mvvm model
class ModelData: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isSignup = false
    
    @Published var email_signup = ""
    @Published var password_signup = ""
    @Published var reEnterPassword = ""
    
    @Published var resetEmail = ""
    @Published var isLinkSend = false
    
    func resetPassword() {
        let alert = UIAlertController(title: "Reser Password", message: "Enter yout e-mail to resert your Password", preferredStyle: .alert)
        alert.addTextField { password in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { _ in
            self.resetEmail = alert.textFields![0].text!
            
            self.isLinkSend.toggle()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView()
    }
}
