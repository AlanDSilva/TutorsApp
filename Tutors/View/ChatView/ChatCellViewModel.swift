//
//  ChatCellViewModel.swift
//  Tutors
//
//  Created by Alan on 9.6.2021.
//

import Foundation
import Combine
import Resolver
import FirebaseStorage

class ChatCellViewModel: ObservableObject, Identifiable {
    @Injected var chatRepo: ChatRepo
    @Injected var userRepo: UserRepo
    
    @Published var chat: Chat
    var id: String = ""
    @Published var createdTime = ""
    @Published var message = ""
    @Published var uId = ""
    @Published var otherUser: CUser = CUser()
    @Published var image: UIImage?
    @Published var errMessage: String = ""
    @Published var dateString: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(chat: Chat) {
        self.chat = chat
        self.uId = chatRepo.otherUID(from: chat)
        loadUser()
        
        $chat
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        $chat
            .map { $0.lastMessage.userId == self.uId ? $0.lastMessage.message : "You: \($0.lastMessage.message)"}
            .assign(to: \.message, on: self)
            .store(in: &cancellables)
        $chat
            .map { self.formatDate(date: ($0.lastMessage.createdTime?.dateValue())!)}
            .assign(to: \.dateString, on: self)
            .store(in: &cancellables)
    }
    
    func loadImage() {
        Storage.storage().reference().child(otherUser.photoURL).getData(maxSize: 5 * 1024 * 1024) { data, err in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                if let imageData = data{
                    self.image = UIImage(data: imageData)
                } else {
                    print("couldn't unwrap image data")
                }
            }
        }
    }
    
    func loadUser() {
        userRepo.fetchUser(with: uId) { result in
            switch result {
            case .success(let user):
                self.otherUser = user
            case .failure(let error):
                self.errMessage = error.rawValue
            }
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
        
    }
}
