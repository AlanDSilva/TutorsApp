//
//  MessageCellViewModel.swift
//  Tutors
//
//  Created by Alan on 13.6.2021.
//

import Foundation
import Resolver
import Combine

class MessageCellViewModel: ObservableObject, Identifiable {
    @Injected var userRepo: UserRepo
    
    @Published var message: Message
    @Published var position: Bool = false
    
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(message: Message) {
        self.message = message
        self.position = message.userId == self.userRepo.user.id!
        
        $message
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
