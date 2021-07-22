//
//  EventViewModel.swift
//  Tutors
//
//  Created by Alan on 22.7.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventViewModel: ObservableObject {
    let db = Firestore.firestore()
    
    var chatID: String
    var userID: String
    var otherID: String
    @Published var event: Event = Event(date: formatDate(date: Date()), startTime: formatTime(date: Date()), endTime: formatTime(date: Date()))
    
    init(chatID: String, userID: String, otherID: String) {
        self.chatID = chatID
        self.userID = userID
        self.otherID = otherID
        
        event.senderID = userID
        event.teacherID = userID
        event.studentID = otherID
    }
    
    //MARK: - Property modifiers
    func changeRole(to role: Role) {
        if role == Role.student {
            event.studentID = userID
            event.teacherID = otherID
        }
        if role == Role.teacher {
            event.studentID = otherID
            event.teacherID = userID
        }
    }
    
    func changeDate(to date: Date) {
        event.date = formatDate(date: date)
    }
    
    func changeStartTime(to date: Date) {
        event.startTime = formatTime(date: date)
    }
    
    func changeEndTime(to date: Date) {
        event.endTime = formatTime(date: date)
    }
    
    
    //MARK: - Sending Invitation
    func sendInvitation() {
        createEvent() { eventID, error in
            if let eventID = eventID {
                print("The event ID will be \(eventID)")
                self.sendMessage(Message(message: "EVENT REQUEST",userId: self.userID, eventId: eventID))
            }
        }
    }
    
    func createEvent(completion: @escaping (String?, Error?) -> Void)  {
        let eventPath = "events"
        
        print("[EventVM] Creating event...")
        do {
            let new_event = try db.collection(eventPath).addDocument(from: event)
            print("Will send event with ID: \(new_event.documentID)")
            completion(new_event.documentID, nil)
        } catch let error {
            print("Error writing event to Firestore: \(error)")
            completion(nil, error)
        }
    }
    
    func sendMessage(_ message: Message){
        let chatPath = "chats"
        let messagePath = "messages"
        
        print("[EventVM] Sending event message... \(message)")
        do {
            try db.collection(chatPath).document(chatID).collection(messagePath).addDocument(from: message)
        } catch let error {
            print("Error writing message to Firestore: \(error)")
        }
    }
}
