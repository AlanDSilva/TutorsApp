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
    @Published var tutorsRepo: TutorsRepo = Resolver.resolve()
    @Published var tutorViewModels = [TutorViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        tutorsRepo.$tutors
            .map { tutors in
                tutors.map { tutor in
                    TutorViewModel(tutor: tutor)
                }
            }
            .assign(to: \.tutorViewModels, on: self)
            .store(in: &cancellables)
    }
    
    func addTutor(_ tutor: Tutor) {
        print("Will make favorite")
    }
    
 }
