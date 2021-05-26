//
//  SignupView.swift
//  Tutors
//
//  Created by Alan on 22.5.2021.
//

import SwiftUI

struct SignupView: View {
    //MARK: - properties
    @ObservedObject var model: AuthViewModel

    
    //MARK: - body
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack {
                VStack(spacing: 20) {
                    CustomTextField(image: "person", placeholder: "Email", text: $model.email_signup)
                    CustomTextField(image: "lock", placeholder: "Password", text: $model.password_signup)
                    CustomTextField(image: "lock", placeholder: "Re-Enter Password", text: $model.reEnterPassword)
                }
                .padding(.top)
                
                Button(action: {model.signup()}){
                    Text("Signup")
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 20)
                        .background(colorGray)
                        .clipShape(Capsule())
                }
                .padding(.top, 22)
                
                
                
            }
            
            Button(action: {
                model.isSignup = false
            }) {
                Image(systemName: "xmark")
                    .padding()
                    .background(colorGray)
                    .clipShape(Circle())
            }
            .padding(.trailing)
            .padding(.top, 10)
            
            if model.isLoading {
                LoadingView()
            }
        }//: zstack
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMessage), dismissButton: .destructive(Text("OK"), action: {
                if model.alertMessage == "Email Verification has been sent" {
                    model.isSignup = false
                    model.email_signup = ""
                    model.password_signup = ""
                    model.reEnterPassword = ""
                }
            }))
        })
    }
}


//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView(isSignup: .constant(true))
//    }
//}
