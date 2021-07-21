//
//  MessageCellViewModel.swift
//  Tutors
//
//  Created by Alan on 13.6.2021.
//

import Foundation
import Resolver
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageCellViewModel: ObservableObject, Identifiable {
    @Injected var userRepo: UserRepo
    
    @Published var message: Message
    @Published var position: Bool = false
    @Published var eventInfo: Event?
    
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(message: Message) {
        self.message = message
        if let eventID = message.eventId {
            getEvent(from: eventID)
        }
        self.position = message.userId == self.userRepo.user.id!
        
        $message
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    func getEvent(from eventID: String) {
        let eventPath = "events"
        let db = Firestore.firestore()
        
        db.collection(eventPath).document(eventID).getDocument { document, error in
            let result = Result {
                  try document?.data(as: Event.self)
                }
                switch result {
                case .success(let event):
                    if let event = event {
                        // A `Event` value was successfully initialized from the DocumentSnapshot.
                        print("Event: \(event)")
                        self.eventInfo = event
                        
                    } else {
                        // A nil value was successfully initialized from the DocumentSnapshot,
                        // or the DocumentSnapshot was nil.
                        print("Document does not exist")
                        self.message.message = "Event invitation was deleted or rejected"
                    }
                case .failure(let error):
                    // A `Event` value could not be initialized from the DocumentSnapshot.
                    print("Error decoding event: \(error)")
                }
        }
    }
    
    func acceptEvent(of eventID: String) {
        let eventPath = "events"
        let db = Firestore.firestore()
        
        db.collection(eventPath).document(eventID).updateData(["confirmed" : true])
    }
    
    func removeEvent(of eventID: String) {
        let eventPath = "events"
        let db = Firestore.firestore()
        
        db.collection(eventPath).document(eventID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
