//
//  ChatRepo.swift
//  Tutors
//
//  Created by Alan on 2.6.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

import Combine
import Resolver

class BaseChatRepo {
    @Published var chats = [Chat]()
    @Published var currentChatId = ""
}

protocol ChatRepo {
    func addChat(_ chat: Chat)
    func updateChat(_ chat: Chat)
}

class FirestoreChatRepo: BaseChatRepo, ChatRepo, ObservableObject {
    @Injected var authenticationService: AuthenticationService
    let db = Firestore.firestore()
    
    var chatsPath: String = "chats"
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
        listenerRegistration = db.collection(chatsPath)
            .whereField("members", arrayContains: self.userId)
            .addSnapshotListener { querySnapshot, error in
                if let qSnapshot = querySnapshot {
                    self.chats = qSnapshot.documents.compactMap{ document in
                        try? document.data(as: Chat.self)
                    }
                }
            }
    }
    
    func addChat(_ chat: Chat) {
        if let foundChat = chats.first(where: { $0.members.contains(chat.members[0])}) {
            print("Will move to chat \(foundChat.id ?? "")")
            currentChatId = foundChat.id!
        } else {
            do {
                var newChat = chat
                newChat.members.append(self.userId)
                print("Inside add chat with chat: \(chat)")
                let new_chat = try db.collection(chatsPath).addDocument(from: newChat)
                print("Will move to new chat \(new_chat.documentID)")
                currentChatId = new_chat.documentID
            }
            catch {
                fatalError("Unable to encode chat: \(error.localizedDescription).")
            }
        }
        
        
    }
    
    func updateChat(_ chat: Chat) {
        if let chatID = chat.id {
            do {
                try db.collection(chatsPath).document(chatID).setData(from: chat)
            }
            catch {
                fatalError("Unable to encode chat: \(error.localizedDescription).")
            }
        }
    }
    
}
