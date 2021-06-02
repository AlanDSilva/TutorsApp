//
//  SettingsViewModel.swift
//  Tutors
//
//  Created by Alan on 28.5.2021.
//

import Foundation
import Combine
import Resolver
import Firebase
import FirebaseStorage

class SettingsViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAnonymous = true
    @Published var email: String = ""
    @Published var displayName: String = ""
    @Published var uid: String = ""
    
    @Published private var authenticationService: AuthenticationService = Resolver.resolve()
    @Published private var tutorRepo: TutorRepo = Resolver.resolve()
    
    private var cancellables = Set<AnyCancellable>()
    
    let storage = Storage.storage()
    
    init() {
        authenticationService.$user.compactMap { user in
            user?.isAnonymous
        }
        .assign(to: \.isAnonymous, on: self)
        .store(in: &cancellables)
        
        authenticationService.$user.compactMap { user in
            user?.email
        }
        .assign(to: \.email, on: self)
        .store(in: &cancellables)
        
        authenticationService.$user.compactMap { user in
            user?.displayName
        }
        .assign(to: \.displayName, on: self)
        .store(in: &cancellables)
        
        authenticationService.$user.compactMap { user in
            user?.uid
        }
        .assign(to: \.uid, on: self)
        .store(in: &cancellables)
    }
    
    func logout() {
        self.authenticationService.signOut()
    }
    
    func updateDisplayName(displayName: String) {
        self.authenticationService.updateDisplayName(displayName: displayName) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(_):
                print("Display name succesfully updated")
            }
        }
    }
    
    func createTutor() {
        let tutor = Tutor(displayName: displayName, description: "", subjects: [])
        tutorRepo.addTutor(tutor)
        print("New tutor added: \(tutor)")
    }
}
