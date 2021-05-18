//
//  CardGridView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct CardGridView: View {
    //MARK: - properties
    let tutors: [Tutor]
    
    //MARK: - body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridLayout, spacing: rowSpacing ,content: {
                ForEach(tutors) {tutor in
                    CardView(tutor: tutor)
                }//: loop
            })//: grid
            .padding(15)
        }
    }
}

struct CardGridView_Previews: PreviewProvider {
    static var previews: some View {
        CardGridView(tutors: Tutor.data)
            .background(colorBackground)
    }
}
