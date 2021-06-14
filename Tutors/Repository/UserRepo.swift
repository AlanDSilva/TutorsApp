//
//  UserRepo.swift
//  Tutors
//
//  Created by Alan on 10.6.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

import Combine
import Resolver

class BaseUserRepo {
    @Published var user: CUser = CUser()
    @Published var users = [CUser]()
}

protocol UserRepo: BaseUserRepo {
    func updateUser(_ user: CUser)
    func fetchUser(with userID: String, completion: @escaping (Result<CUser, DatabaseError>) -> ())
}

class FirestoreUserRepo: BaseUserRepo, UserRepo, ObservableObject {
    
    @Injected var authenticationService: AuthenticationService
    let db = Firestore.firestore()
    
    var userId: String = "unknown"
    var usersPath: String = "users"
    
    private var listenerRegistration: ListenerRegistration?
    private var listenerRegistration2: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()
    
    
    
    override init() {
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
            }
            .store(in: &cancellables)
    }
    
    
    func loadData() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
        }
        listenerRegistration = db.collection(usersPath).document(userId)
            .addSnapshotListener{ docSnapshot, error in
                guard let document = docSnapshot else {
                    print("Error fetching document: \(error!.localizedDescription)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty. Creating user document...")
                    do {
                        try self.db.collection(self.usersPath).document(self.userId).setData(from: CUser(displayName: "", photoURL: ""))
                    } catch let error {
                        print("Error writing city to Firestore: \(error)")
                    }
                    return
                }
                print("Current data: \(data)")
                self.user = try! document.data(as: CUser.self)!
            }
    }
    
    func fetchUser(with userID: String, completion: @escaping (Result<CUser, DatabaseError>) -> ()) {
        let docRef = db.collection(usersPath).document(userID)

        docRef.getDocument { (snap, error) in
            if let _ = error {
                completion(.failure(.failed))
                return
            }
            
            guard let userData = try? snap?.data(as: CUser.self) else {
                completion(.failure(.failed))
                return
            }
            
            completion(.success(userData))
        }
    }
    
    func updateUser(_ user: CUser) {
        do {
            try db.collection(usersPath).document(userId).setData(from: user)
        }
        catch {
            fatalError("Unable to encode task: \(error.localizedDescription).")
        }
    }
}

enum DatabaseError: String, Error {
    case failed = "Failed to fetch from database"
}

