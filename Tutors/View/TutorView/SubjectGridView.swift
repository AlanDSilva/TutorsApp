//
//  SubjectGridView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct SubjectGridView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                Section(
                    header: SectionView(rotateClockwise: false),
                    footer: SectionView(rotateClockwise: true)) {
                    ForEach(0..<4) { subject in
                        SubjectItemView(subject: "Music")
                    }
                }
            })//: grid
            .frame(height: 130)
        }//: scroll
    }
}

struct SubjectGridView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectGridView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)
    }
}
