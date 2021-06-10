//
//  MessageListViewModel.swift
//  Tutors
//
//  Created by Alan on 9.6.2021.
//

import Foundation
import Combine

class MessageListViewModel: ObservableObject {
    @Published var messageRepo: FirestoreMessageRepo
    @Published var messages = [Message]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ id: String) {
        messageRepo = FirestoreMessageRepo(id)
        messageRepo.$messages
            .map { messages in
                messages
            }
            .assign(to: \.messages, on: self)
            .store(in: &cancellables)
    }
    
    func sendMessage(_ message: String){
        print("Call send message inside ViewModel")
        messageRepo.addMessage(Message(message: message, userId: ""))
    }
}
