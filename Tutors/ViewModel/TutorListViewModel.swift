//
//  TutorListViewModel.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import Foundation
import Combine
import Resolver

class TutorListViewModel: ObservableObject {
    @Published var tutorRepo: TutorRepo = Resolver.resolve()
    @Published var tutorViewModels = [TutorViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        tutorRepo.$tutors
            .map { tutors in
                tutors.map { tutor in
                    TutorViewModel(tutor: tutor)
                }
            }
            .assign(to: \.tutorViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addTutor(_ tutor: Tutor) {
        tutorRepo.addTutor(tutor)
    }
    
 }
