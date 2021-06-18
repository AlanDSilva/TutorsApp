//
//  InfoCardView.swift
//  Tutors
//
//  Created by Alan on 18.6.2021.
//

import SwiftUI

struct InfoCardView: View {
    var displayName: String = "Full Name"
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(displayName)
                    .font(.title3)
                Image(systemName: "pin")
                Text("Helsinki")
            }
            HStack {
                Image(systemName: "star")
                Text("3.4")
                Image(systemName: "person.2")
                Text("300")
                Image(systemName: "play")
                Text("2")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.white).shadow(color: Color.gray, radius: 5.0, x: CGFloat(0.7), y: CGFloat(0.3)))
        
    }
}

struct InfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardView()
    }
}
