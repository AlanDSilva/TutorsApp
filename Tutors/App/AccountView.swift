//
//  AccountView.swift
//  Tutors
//
//  Created by Alan on 17.5.2021.
//

import SwiftUI
import FirebaseStorage

struct AccountView: View {
    //MARK: - properties
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @State private var showSignInView = false
    @State private var showEditDisplayName = false
    @State private var showPhotoPicker = false
    
    @State var image: UIImage?
    
    //MARK: - body
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    if(settingsViewModel.image != nil) {
                        Image(uiImage: settingsViewModel.image!)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "timelapse")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                    
                    Button(action: { showPhotoPicker.toggle() }) {
                        Image(systemName: "camera.circle")
                    }
                }
                
                Text("This is an anonymous account")
                
                Text("UID: \(settingsViewModel.cUser.id != "" ? settingsViewModel.cUser.id! : "[None]")")
                HStack {
                    Text("Username: \(settingsViewModel.cUser.displayName != "" ? settingsViewModel.cUser.displayName : "[None]")")
                    Spacer()
                    Button(action: { showEditDisplayName.toggle() }) {
                        Image(systemName: "pencil.circle")
                    }
                }
                Spacer()
                NavigationLink(destination: TutorPageView()) {
                    Text("Go to TutorPAge")
                }
                
                Button(action: {settingsViewModel.createTutor()}, label: {
                    Text("Register as tutor")
                })
                

            }
            .padding()
            .sheet(isPresented: self.$showSignInView) {
                Text("Will sign in")
            }
            .sheet(isPresented: self.$showEditDisplayName) {
                EditName(displayName: settingsViewModel.cUser.displayName, settingsViewModel: settingsViewModel)
            }
            .sheet(isPresented: self.$showPhotoPicker) {
                PhotoPickerView(uid: settingsViewModel.cUser.id!, settingsViewModel: settingsViewModel, image: settingsViewModel.image)
            }
            .onAppear {
                if settingsViewModel.cUser.photoURL != "" {
                    settingsViewModel.loadImage()
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    func login() {
        self.showSignInView.toggle()
    }
    
    func logout() {
        print("Will log out")
    }
    
}

struct EditName: View {
    //MARK: - properties
    @State var displayName: String
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    //MARK: - body
    var body: some View {
        HStack {
            TextField("Display name", text: $displayName)
            Spacer()
            Button {
                settingsViewModel.updateDisplayName(displayName: displayName)
            } label: {
                Image(systemName: "pencil.circle")
            }
            
        }
        .padding()
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
