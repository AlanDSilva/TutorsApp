//
//  TutorRepository.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TutorRepo: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var tutors = [Tutor]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        db.collection("tutors").addSnapshotListener { querySnapshot, error in
            if let qSnapshot = querySnapshot {
                self.tutors = qSnapshot.documents.compactMap{ document in
                    try? document.data(as: Tutor.self)
                }
            }
        }
    }
    
    func addTutor(_ tutor: Tutor) {
        do {
            let _ = try db.collection("tutors").addDocument(from: tutor)
        } catch {
            fatalError("Unable to encode task: \(tutor)")
        }
    }
    
    
}



