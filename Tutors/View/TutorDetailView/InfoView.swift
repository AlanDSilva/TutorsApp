//
//  InfoView.swift
//  Tutors
//
//  Created by Alan on 15.6.2021.
//

import SwiftUI

struct InfoView: View {
    var infoImage: String
    var infoText: String
    
    var body: some View {
        HStack{
            Image(systemName: infoImage)
            Text(infoText)
        }
    }
}

