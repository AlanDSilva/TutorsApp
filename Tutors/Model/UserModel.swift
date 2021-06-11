//
//  UserModel.swift
//  Tutors
//
//  Created by Alan on 10.6.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CUser: Codable, Identifiable {
    @DocumentID var id: String? = ""
    var displayName: String = ""
    var photoURL: String = ""
}
