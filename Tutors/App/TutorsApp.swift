//
//  TutorsApp.swift
//  Tutors
//
//  Created by Alan on 17.5.2021.
//

import SwiftUI
import Firebase

@main
struct TutorsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
