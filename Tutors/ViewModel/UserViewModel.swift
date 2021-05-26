//
//  UserViewModel.swift
//  Tutors
//
//  Created by Alan on 25.5.2021.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var user: User = User(email: "")
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        if let currentUser = Auth.auth().currentUser {
            db.collection("users").document(currentUser.uid).addSnapshotListener { snapshot, error in
                guard let document = snapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                print("Current data: \(data)")
                self.user = try! document.data(as: User.self)!
            }
        }
    }
    
    func updateUser(_ user: User) {
        if let uid = user.id {
            do{
                try db.collection("users").document(uid).setData(from: user)
            } catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
    
    
}
