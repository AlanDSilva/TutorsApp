//
//  TutorRepository.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

import Combine
import Resolver

class BaseTutorsRepo {
    @Published var tutors = [Tutor]()
}

protocol TutorsRepo: BaseTutorsRepo {
    func makeFavorite(_ tutor: Tutor)
    func removeFavorite(_ tutor: Tutor)
}


class FirestoreTutorsRepo: BaseTutorsRepo, TutorsRepo, ObservableObject {
    func makeFavorite(_ tutor: Tutor) {
        print("Will make tutor favorite")
    }
    
    func removeFavorite(_ tutor: Tutor) {
        print("Will remove tutor from favorites")
    }
    
    @Injected var authenticationService: AuthenticationService
    let db = Firestore.firestore()
    
    var tutorsPath: String = "tutors"
    var userId: String = "unknown"
    
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
    }
    
    
    func loadData() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
        }
        listenerRegistration = db.collection(tutorsPath)
            .addSnapshotListener { querySnapshot, error in
                if let qSnapshot = querySnapshot {
                    self.tutors = qSnapshot.documents.compactMap{ document in
                        try? document.data(as: Tutor.self)
                    }
                }
            }
    }
    
}



