//
//  TutorPageViewModel.swift
//  Tutors
//
//  Created by Alan on 1.6.2021.
//

import Foundation
import Resolver
import Combine

class TutorPageViewModel: ObservableObject {
    @Published var tutorRepo: TutorRepo = Resolver.resolve()
    @Published var tutor: Tutor = Tutor()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        tutorRepo.$tutor.map{ tutor in
            tutor
        }
        .assign(to: \.tutor, on: self)
        .store(in: &cancellables)
    }
    
    func updateTutor(_ tutor: Tutor) {
        tutorRepo.updateTutor(tutor)
    }
    
}
