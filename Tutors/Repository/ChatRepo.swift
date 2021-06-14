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
//    @Published var currentChatId = ""
}

protocol ChatRepo: BaseChatRepo {
    func startChat(with id: String) -> String
    func otherUID(from chat: Chat) -> String
    func updateChat(of chatID: String, with message: Message)
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
    
    func startChat(with id: String) -> String {
        if let foundChat = chats.first(where: { $0.members.contains(id)}) {
            print("Will move to chat \(foundChat.id ?? "")")
            return foundChat.id!
        } else {
            print("Will create a chat")
            do {
                var newChat = Chat()
                newChat.members.append(self.userId)
                newChat.members.append(id)
                print("Creating new chat: \(newChat)")
                let new_chat = try db.collection(chatsPath).addDocument(from: newChat)
                print("Will move to new chat \(new_chat.documentID)")
                return new_chat.documentID
            }
            catch {
                fatalError("Unable to encode chat: \(error.localizedDescription).")
            }
        }
    }
    
    func otherUID(from chat: Chat) -> String {
        chat.members.first { $0 != userId } ?? ""
    }
    
    func getChat(of chatID: String) -> Chat {
        chats.first { $0.id == chatID }!
    }
    
    func updateChat(of chatID: String, with message: Message) {
        var updatedChat = getChat(of: chatID)
        updatedChat.lastMessage = message
            do {
                try db.collection(chatsPath).document(chatID).setData(from: updatedChat)
                print("chat succesfully updated")
            }
            catch {
                fatalError("Unable to encode chat: \(error.localizedDescription).")
            }
    }
    
}
