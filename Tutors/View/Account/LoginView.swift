//
//  LoginView.swift
//  Tutors
//
//  Created by Alan on 22.5.2021.
//

import SwiftUI

struct LoginView: View {
    //MARK: - properties
    @ObservedObject var model: AuthViewModel
    
    //MARK: - body
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 20) {
                    CustomTextField(image: "person", placeholder: "Email", text: $model.email)
                    CustomTextField(image: "lock", placeholder: "Password", text: $model.password)
                }
                .padding(.top)
                
                Button(action: {model.login()}){
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
            } //: vstack
            .fullScreenCover(isPresented: $model.isSignup, content: {
                SignupView(model: model)
            })
            .alert(isPresented: $model.isLinkSend, content: {
                Alert(title: Text("Message"), message: Text("Password Reset Link Has Been Sent"), dismissButton: .destructive(Text("OK")))
            })
            .alert(isPresented: $model.alert, content: {
                Alert(title: Text("Message"), message: Text(model.alertMessage), dismissButton: .destructive(Text("OK")))
            })
            
            if model.isLoading {
                LoadingView()
            }
        }//: zstack
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

//struct LoginView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        LoginView()
//        
//    }
//}
