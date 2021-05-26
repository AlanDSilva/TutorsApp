//
//  UserModel.swift
//  Tutors
//
//  Created by Alan on 24.5.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    let email: String
    
    init(email: String) {
        self.email = email
        self.name = ""
    }
}
