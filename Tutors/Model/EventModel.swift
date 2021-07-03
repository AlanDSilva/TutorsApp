//
//  EventModel.swift
//  Tutors
//
//  Created by Alan on 22.6.2021.
//

import Foundation

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Event: Identifiable, Codable {
    @DocumentID var id: String? = ""
    var teacherID: String = ""
    var studentID: String = ""
    var date: String = ""
    var startTime: String = ""
    var endTime: String = ""
}
