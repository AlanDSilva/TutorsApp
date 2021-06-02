//
//  CardGridView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct CardGridView: View {
    //MARK: - properties
    @ObservedObject var tutorListVM = TutorListViewModel()
//    let tutors: [Tutor] = Tutor.data
    
    //MARK: - body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridLayout, spacing: rowSpacing ,content: {
                ForEach(tutorListVM.tutorViewModels) {tutorVM in
                    NavigationLink(destination: TutorDetailView(tutorVM: tutorVM)) {
                        CardView(tutorVM: tutorVM)
                    }
                    
                }//: loop
            })//: grid
            .padding(15)
        }
    }
}

struct CardGridView_Previews: PreviewProvider {
    static var previews: some View {
        CardGridView()
            .background(colorBackground)
    }
}
