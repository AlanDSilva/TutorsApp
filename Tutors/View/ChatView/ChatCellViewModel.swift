//
//  ChatCellViewModel.swift
//  Tutors
//
//  Created by Alan on 9.6.2021.
//

import Foundation
import Combine

class ChatCellViewModel: ObservableObject, Identifiable {
    @Published var chat: Chat
    @Published var messageListVM: MessageListViewModel
    var id: String = ""
    @Published var createdTime = ""
    @Published var message = ""
    @Published var userId = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(chat: Chat, messageListVM: MessageListViewModel) {
        self.chat = chat
        self.messageListVM = messageListVM
        
        $chat
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        $chat
            .map { $0.lastMessage.message }
            .assign(to: \.message, on: self)
            .store(in: &cancellables)
    }
}
