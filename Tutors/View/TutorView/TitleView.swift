//
//  TitleView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct TitleView: View {
    //MARK: - properties
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Spacer()
        }//: hstack
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Tutors")
            .previewLayout(.sizeThatFits)
            .background(colorBackground)
    }
}
