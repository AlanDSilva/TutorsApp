//
//  ChatListViewModel.swift
//  Tutors
//
//  Created by Alan on 9.6.2021.
//

import Foundation
import Resolver
import Combine

class ChatListViewModel: ObservableObject {
    @Published var chatRepo: ChatRepo = Resolver.resolve()
    @Published var chatCellVMs = [ChatCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        chatRepo.$chats
            .map { chats in
                chats.map { chat in
                    ChatCellViewModel(chat: chat, messageListVM: MessageListViewModel(chat.id!))
                }
            }
            .assign(to: \.chatCellVMs, on: self)
            .store(in: &cancellables)
    }
}
