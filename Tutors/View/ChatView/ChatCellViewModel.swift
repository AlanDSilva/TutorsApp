//
//  ChatCellViewModel.swift
//  Tutors
//
//  Created by Alan on 9.6.2021.
//

import Foundation
import Combine
import Resolver

class ChatCellViewModel: ObservableObject, Identifiable {
    @Injected var chatRepo: ChatRepo
    @Injected var userRepo: UserRepo
    
    @Published var chat: Chat
    var id: String = ""
    @Published var createdTime = ""
    @Published var message = ""
    @Published var uId = ""
    @Published var otherUser: CUser = CUser()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(chat: Chat) {
        self.chat = chat
        self.uId = chatRepo.otherUID(from: chat)
        
        $chat
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        $chat
            .map { $0.lastMessage.message }
            .assign(to: \.message, on: self)
            .store(in: &cancellables)
        
    }
    
    func getUser() {
        userRepo.getUser(with: chatRepo.otherUID(from: chat)) { cUser in
            print("What returns is: \(cUser)")
            self.otherUser = cUser
            print("What actually returns is: \(self.otherUser)")
        }
    }
}
