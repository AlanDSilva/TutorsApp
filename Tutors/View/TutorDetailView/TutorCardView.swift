//
//  TutorCardView.swift
//  Tutors
//
//  Created by Alan on 15.6.2021.
//

import SwiftUI

struct TutorCardView: View {
    var body: some View {
        HStack(spacing: 20){
            Image("cat6")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 100, maxHeight: 150)
                .clipShape(RoundedRectangle(cornerRadius: 25))
            VStack(alignment: .leading){
                Spacer()
                Text("Tutor Name").font(.title3)
                Spacer()
                HStack(spacing: 20){
                    InfoView(infoImage: "person.2.fill", infoText: "56")
                    InfoView(infoImage: "star.fill", infoText: "4.6")
                    InfoView(infoImage: "play.fill", infoText: "10")
                }
                .font(.caption2)
                Spacer()
            }
            Spacer()
        }
    }
    
}

struct TutorCardView_Previews: PreviewProvider {
    static var previews: some View {
        TutorCardView()
    }
}
