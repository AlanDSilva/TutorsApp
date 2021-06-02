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
                    if(image != nil) {
                        Image(uiImage: image!)
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
                
                Text("UID: \(settingsViewModel.uid != "" ? settingsViewModel.uid : "[None]")")
                HStack {
                    Text("Username: \(settingsViewModel.displayName != "" ? settingsViewModel.displayName : "[None]")")
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
                SignInView()
            }
            .sheet(isPresented: self.$showEditDisplayName) {
                EditName(displayName: settingsViewModel.displayName, settingsViewModel: settingsViewModel)
            }
            .sheet(isPresented: self.$showPhotoPicker) {
                PhotoPickerView(uid: settingsViewModel.uid)
            }
            .onAppear {
                loadImage()
            }
            .navigationTitle("Settings")
        }
        
    }
    
    //MARK: - methods
    func loadImage() {
        Storage.storage().reference().child("\(settingsViewModel.uid)/temp").getData(maxSize: 5 * 1024 * 1024) { data, err in
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
    
    func login() {
        self.showSignInView.toggle()
    }
    
    func logout() {
        self.settingsViewModel.logout()
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
