//
//  TutorViewModel.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import Foundation
import Combine
import Resolver

class TutorViewModel: ObservableObject, Identifiable {
    @Published var tutorRepo: TutorRepo = Resolver.resolve()
    @Published var chatRepo: ChatRepo = Resolver.resolve()
    @Published var tutor: Tutor = Tutor()
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(tutor: Tutor) {
        self.tutor = tutor
    }
    
    func startChat() {
        print("Will start chat")
        let chat = Chat(members: [self.tutor.id!])
        chatRepo.addChat(chat)
    }
}
