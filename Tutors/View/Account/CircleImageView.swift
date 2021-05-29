//
//  CircleImageView.swift
//  Tutors
//
//  Created by Alan on 29.5.2021.
//

import SwiftUI

struct CircleImageView: View {
    var body: some View {
        Image("cat6")
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 3))
            .shadow(radius: 4)
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
    }
}
