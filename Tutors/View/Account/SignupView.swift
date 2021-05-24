//
//  SignupView.swift
//  Tutors
//
//  Created by Alan on 22.5.2021.
//

import SwiftUI

struct SignupView: View {
    //MARK: - properties
//    @State var email: String = ""
//    @State var password: String = ""
//    @State var rePassword: String = ""
//    @Binding var isSignup: Bool
    @ObservedObject var model: ModelData

    
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
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
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
        }
    }
}


//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView(isSignup: .constant(true))
//    }
//}
