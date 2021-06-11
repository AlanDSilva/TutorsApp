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
    
    func registerTutor() {
        tutorRepo.createTutor()
    }
    
    func removeTutor() {
        tutorRepo.deleteTutor()
    }
    
    func updateDescription(with description: String){
        var tutor = self.tutor
        tutor.description = description
        tutorRepo.updateTutor(tutor)
    }
    
    func updateSubjects(with subjects: [String]) {
        var tutor = self.tutor
        tutor.subjects = subjects
        tutorRepo.updateTutor(tutor)
    }
    
}
