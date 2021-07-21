//
//  EventRepo.swift
//  Tutors
//
//  Created by Alan on 5.7.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

import Combine
import Resolver

class BaseEventRepo {
    @Published var events = [Event]()
}

protocol EventRepo: BaseChatRepo {
    func createEvent()
    func deleteEvent()
    func updateEvent(with event: Event)
}

class FirestoreEventRepo: BaseTutorRepo, TutorRepo, ObservableObject {
    @Injected var authenticationService: AuthenticationService
    @Injected var userRepo: UserRepo
    let db = Firestore.firestore()
    
    var eventsPath: String = "events"
    
    func createTutor() {
        
    }
    
    func deleteTutor() {
        
    }
    
    func updateTutor(_ tutor: Tutor) {
        
    }
    
}
