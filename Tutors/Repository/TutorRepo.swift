//
//  TutorRepo.swift
//  Tutors
//
//  Created by Alan on 11.6.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

import Combine
import Resolver

class BaseTutorRepo {
    @Published var tutor = Tutor()
}

protocol TutorRepo: BaseTutorRepo {
    func createTutor()
    func deleteTutor()
    func updateTutor(_ tutor: Tutor)
}


class FirestoreTutorRepo: BaseTutorRepo, TutorRepo, ObservableObject {
    @Injected var authenticationService: AuthenticationService
    @Injected var userRepo: UserRepo
    let db = Firestore.firestore()
    
    var tutorsPath: String = "tutors"
    var userId: String = "unknown"
    var user: CUser = CUser()
    
    private var listenerRegistration: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    
    override init(){
        super.init()
        
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        // (re)load data if user changes
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.loadData()
            }
            .store(in: &cancellables)
        
        userRepo.$user
            .map{ user in
                user
            }
            .assign(to: \.user, on: self)
            .store(in: &cancellables)
    }
    
    
    func loadData() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
        }
        listenerRegistration = db.collection(tutorsPath).document(userId)
            .addSnapshotListener { docSnapshot, error in
                guard let document = docSnapshot else {
                    print("Error fetching TUTOR document: \(error!.localizedDescription)")
                    return
                }
                guard let data = document.data() else {
                    print("TUTOR document data was empty for the user \(self.user)")
                    return
                }
                print("Current TUTOR data: \(data)")
                self.tutor = try! document.data(as: Tutor.self)!
            }
    }
    
    func createTutor() {
        print("Will create tutor")
        do {
            try self.db.collection(self.tutorsPath).document(self.userId).setData(from: Tutor(displayName: user.displayName, photoURL: user.photoURL))
        } catch let error {
            print("Error writing tutor to Firestore: \(error)")
        }
    }
    
    func updateTutor(_ tutor: Tutor) {
        print("Will update tutor")
        do {
            try self.db.collection(self.tutorsPath).document(self.userId).setData(from: tutor)
        } catch let error {
            print("Error updating tutor to Firestore: \(error)")
        }
    }
    
    func deleteTutor() {
        db.collection(tutorsPath).document(userId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
