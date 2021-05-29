//
//  SubjectItemView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct SubjectItemView: View {
    //MARK: - properties
    let subject: String
    
    //MARK: - body
    var body: some View {
        
        HStack(alignment: .center, spacing: 6) {
            Image(systemName: "book")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15, alignment: .center)
            
            Text(subject.uppercased())
                .font(.footnote)
                .fontWeight(.light)
            
            Spacer()
        }//: hstack
        .padding()
        .background(Color.white.cornerRadius(12))
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 1)
        )
        
    }
}

struct SubjectItemView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectItemView(subject: "English")
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}
