//
//  AccountDetailView.swift
//  Tutors
//
//  Created by Alan on 24.5.2021.
//

import SwiftUI
import FirebaseStorage

struct AccountDetailView: View {
    //MARK: - properties
    @ObservedObject var model: AuthViewModel
    @ObservedObject var userVM: UserViewModel
    @State var isEditing: Bool = false
    @State var isPhotoPicker: Bool = false
    @State var image: UIImage?
    
    //MARK: - body
    var body: some View {
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .padding()
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .padding()
                }
                EditButton(image: "camera.circle", isShowing: $isPhotoPicker)
                    .padding()
            }//: zstack
            
            Text("Logged in as \(userVM.user.email)")
            HStack {
                Text("Username is \(userVM.user.name)")
                EditButton(image: "pencil.circle", isShowing: $isEditing)
            }
            
            
            Button(action: {
                userVM.logout()
            }){
                Text("Logout")
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .background(colorGray)
                    .clipShape(Capsule())
            }
            .padding(.top, 22)
        }//: vstack
        .sheet(isPresented: $isEditing, content: {
            //            AccountEditView(user: userVM.user)
            AccountEditView(user: userVM.user, userVM: userVM)
        })
        .sheet(isPresented: $isPhotoPicker, content: {
            //            AccountEditView(user: userVM.user)
            PhotoPickerView(uid: userVM.user.id!)
        })
        .onAppear(perform: {
            
            print("View did appear: \(userVM.user)")
            if let uid = userVM.user.id {
                Storage.storage().reference().child("\(uid)/temp").getData(maxSize: 5 * 1024 * 1024) { data, err in
                    if let err = err {
                        print("an error has occurred - \(err.localizedDescription)")
                    } else {
                        if let imageData = data{
                            image = UIImage(data: imageData)
                        } else {
                            print("couldn't unwrap image data")
                        }
                    }
                }
            }
            else {
                print("Error finding uid from user")
            }
        })
        
    }
}

struct EditButton: View {
    let image: String
    @Binding var isShowing: Bool
    
    var body: some View {
        Button(action: {
            isShowing.toggle()
        }, label: {
            Image(systemName: image)
                .foregroundColor(.black)
        })
        .font(.title2)
    }
}


//struct AccountDeailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountDetailView()
//    }
//}
