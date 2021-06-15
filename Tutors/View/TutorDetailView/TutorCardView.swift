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
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 150)
                .background(RoundedRectangle(cornerRadius: 25).stroke())
            VStack(alignment: .leading){
                Spacer()
                Text("Tutor Name").font(.title3)
                Text("Illustrator & Designer").font(.caption)
                Spacer()
                HStack(spacing: 20){
                    SmallInfoView(infoImage: "person.2.fill", infoText: "56")
                    SmallInfoView(infoImage: "star.fill", infoText: "4.6")
                    SmallInfoView(infoImage: "play.fill", infoText: "10")
                }
                .font(.caption2)
                Spacer()
            }
            Spacer()
        }
        .frame(maxHeight: 200)
    }
    
}

struct TutorCardView_Previews: PreviewProvider {
    static var previews: some View {
        TutorCardView()
    }
}
