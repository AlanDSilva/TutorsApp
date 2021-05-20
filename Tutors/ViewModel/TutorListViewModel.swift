//
//  TutorListViewModel.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import Foundation

class TutorListViewModel: ObservableObject {
    @Published var tutorViewModels = [TutorViewModel]()
    
    init() {
        self.tutorViewModels = Tutor.data.map { tutor in
            TutorViewModel(tutor: tutor)
        }
    }
 }
