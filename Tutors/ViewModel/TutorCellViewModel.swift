//
//  TutorViewModel.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import Foundation
import Combine
import Resolver

import FirebaseStorage

class TutorCellViewModel: ObservableObject, Identifiable {
    @Published var chatRepo: ChatRepo = Resolver.resolve()
    @Published var tutor: Tutor
    @Published var image: UIImage?
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(tutor: Tutor) {
        self.tutor = tutor
        loadImage()
    }
    
    func startChat() {
        print("Will start chat")
        chatRepo.startChat(with: tutor.id!)
    }
    
    func loadImage() {
        getImage(of: tutor.photoURL) { image in
            self.image = image
        }
    }
}

func getImage(of path: String, completion: @escaping (UIImage?) -> ()){
    Storage.storage().reference().child(path).getData(maxSize: 5 * 1024 * 1024) { data, error in
        if let _ = error {
            print("Could not get image")
            completion(nil)
        } else {
            let image = UIImage(data: data!)
            print("Image downloaded")
            completion(image)
        }
    }
    
}
