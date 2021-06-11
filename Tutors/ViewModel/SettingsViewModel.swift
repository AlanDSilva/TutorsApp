//
//  SettingsViewModel.swift
//  Tutors
//
//  Created by Alan on 28.5.2021.
//

import Foundation
import SwiftUI
import Combine
import Resolver
import Firebase
import FirebaseStorage

class SettingsViewModel: ObservableObject {
    @Published var cUser = CUser()
    @Published var image: UIImage?
    
    @Published private var tutorRepo: TutorRepo = Resolver.resolve()
    @Published private var userRepo: UserRepo = Resolver.resolve()
    
    private var cancellables = Set<AnyCancellable>()
    
    let storage = Storage.storage()
    
    init() {
        userRepo.$user
            .map{$0}
            .assign(to: \.cUser, on: self)
            .store(in: &cancellables)
    }
    
    func updateDisplayName(displayName: String) {
        var updatedUser = cUser
        updatedUser.displayName = displayName
        self.userRepo.updateUser(updatedUser)
    }
    
    func updatePhotoRL(photoURL: String) {
        var updatedUser = cUser
        updatedUser.photoURL = photoURL
        self.userRepo.updateUser(updatedUser)
    }
    
    func loadImage() {
        Storage.storage().reference().child(cUser.photoURL).getData(maxSize: 5 * 1024 * 1024) { data, err in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                if let imageData = data{
                    self.image = UIImage(data: imageData)
                } else {
                    print("couldn't unwrap image data")
                }
            }
        }
    }
    
    func uploadProfileImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.6) {
            let storage = Storage.storage()
            storage.reference().child("\(cUser.id!)/profilePhoto").putData(imageData, metadata: nil) { _, err in
                if let err = err {
                    print("an error has occurred - \(err.localizedDescription)")
                } else {
                    print("image uploaded succesfully")
                }
            }
        } else {
            print("Couldn't unwrapp/cast image to data")
        }
    }
    
    func createTutor() {
        print("Will create tutor")
    }
}
