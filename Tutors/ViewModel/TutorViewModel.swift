//
//  TutorViewModel.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import Foundation
import Combine

class TutorViewModel: ObservableObject, Identifiable {
    @Published var tutor: Tutor
    
    init(tutor: Tutor) {
        self.tutor = tutor
        
    }
}
