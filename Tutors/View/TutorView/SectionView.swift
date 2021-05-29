//
//  SectionView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct SectionView: View {
    //MARK: - properties
    let rotateClockwise: Bool
    
    //MARK: - body
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("Subjects".uppercased())
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: rotateClockwise ? 90 : -90))
            Spacer()
        }//: vstack
        .background(Color.black.cornerRadius(radius))
        .frame(width: 75)
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(rotateClockwise: false)
            .previewLayout(.fixed(width: 120, height: 240))
            .padding()
            .background(colorBackground)
    }
}
