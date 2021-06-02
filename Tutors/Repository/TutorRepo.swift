//
//  TutorRepository.swift
//  Tutors
//
//  Created by Alan on 20.5.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

import Combine
import Resolver

class BaseTutorRepo {
    @Published var tutors = [Tutor]()
    @Published var tutor: Tutor = Tutor()
}

protocol TutorRepo: BaseTutorRepo {
    func fetchTutor()
    func addTutor(_ tutor: Tutor)
    func updateTutor(_ tutor: Tutor)
}


class FirestoreTutorRepo: BaseTutorRepo, TutorRepo, ObservableObject {
    @Injected var authenticationService: AuthenticationService
    let db = Firestore.firestore()
    
    var tutorsPath: String = "tutors"
    var userId: String = "unknown"
    
    private var listenerRegistration: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    
    override init(){
        super.init()
        
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        // (re)load data if user changes
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.loadData()
//                self?.fetchTutor()
//                print("The user id is \(self?.userId ?? "[None]")")
            }
            .store(in: &cancellables)
    }
    
    
    func loadData() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
        }
        listenerRegistration = db.collection(tutorsPath)
            .addSnapshotListener { querySnapshot, error in
                if let qSnapshot = querySnapshot {
                    self.tutors = qSnapshot.documents.compactMap{ document in
                        try? document.data(as: Tutor.self)
                    }
                    self.fetchTutor()
                }
            }
    }
    
    func fetchTutor() {
        print("Fetching tutor with id: \(userId)")
        db.collection(tutorsPath).document(userId)
            .getDocument { snapshot, err in
                if let document = snapshot, document.exists {
                    print("Document exists!")
                    self.tutor = try! document.data(as: Tutor.self)!
                }else {
                    print("Document does not exist")
                }
            }
    }
    
    
    func addTutor(_ tutor: Tutor) {
        do {
            try db.collection("tutors").document(userId).setData(from: tutor)
        } catch {
            fatalError("Unable to encode task: \(tutor)")
        }
    }
    
    func updateTutor(_ tutor: Tutor) {
        if let tutorID = tutor.id {
            do {
                try db.collection(tutorsPath).document(tutorID).setData(from: tutor)
            }
            catch {
                fatalError("Unable to encode task: \(error.localizedDescription).")
            }
        }
    }
    
    
}



