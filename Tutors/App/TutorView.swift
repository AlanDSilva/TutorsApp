//
//  TutorView.swift
//  Tutors
//
//  Created by Alan on 17.5.2021.
//

import SwiftUI

struct TutorView: View {
    //MARK: - properties
    @State var searchText: String = ""
    
    
    //MARK: - body
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal, 8)
                
                CardGridView(tutors: Tutor.data)
            }
            .navigationBarTitle("Tutors")
        }
        .background(colorBackground)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TutorView()
            .background(colorBackground)
    }
}
