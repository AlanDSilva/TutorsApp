//
//  ChatModel.swift
//  Tutors
//
//  Created by Alan on 2.6.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Chat: Codable, Identifiable {
    @DocumentID var id: String? = ""
    var members: [String] = []
    var lastMessage: Message = Message()
}

struct Message: Codable {
    var message: String = ""
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String = ""
}
