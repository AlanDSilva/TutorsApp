//
//  TutorModel.swift
//  Tutors
//
//  Created by Alan on 17.5.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Tutor: Identifiable, Codable {
    @DocumentID var id: String? = ""
    var displayName: String = ""
    var photoURL: String = ""
    var description: String = ""
    var subjects: [String] = []
}

extension Tutor {
    static var data: [Tutor] {
        [
            Tutor(displayName: "Alan Da Silva", description: "Venison pork loin andouille picanha, beef short loin jerky shoulder. Boudin pork chop bacon brisket, cupim frankfurter meatball ribeye alcatra short loin shankle drumstick ham doner shoulder. Ground round hamburger filet mignon tri-tip tenderloin jowl turkey pork leberkas alcatra beef boudin short loin picanha porchetta.", subjects: ["iOS", "Android"]),
            Tutor(displayName: "Miika Tynkkynen", description: "Venison pork loin andouille picanha, beef short loin jerky shoulder. Boudin pork chop bacon brisket, cupim frankfurter meatball ribeye alcatra short loin shankle drumstick ham doner shoulder. Ground round hamburger filet mignon tri-tip tenderloin jowl turkey pork leberkas alcatra beef boudin short loin picanha porchetta.", subjects: ["Finnish", "English", "Swedish"]),
            Tutor(displayName: "Uli Manuensa", description: "Venison pork loin andouille picanha, beef short loin jerky shoulder. Boudin pork chop bacon brisket, cupim frankfurter meatball ribeye alcatra short loin shankle drumstick ham doner shoulder. Ground round hamburger filet mignon tri-tip tenderloin jowl turkey pork leberkas alcatra beef boudin short loin picanha porchetta.", subjects: ["Economics", "Maths", "Physics", "Portuguese"])
        ]
    }
}
