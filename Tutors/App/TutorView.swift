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
    @State var isEditing: Bool = false
    
    @State var results = []
    @State var selectedFilter: Filter = Filter.recent
    
    
    //MARK: - body
    var body: some View {
        NavigationView {
            ZStack {
                colorBackground.edgesIgnoringSafeArea(.all)
                if isEditing {
                    VStack {
                        SearchBar(text: $searchText, isEditing: $isEditing)
                            .padding(.bottom)
                        TutorListView()
                    }
                    
                        
                } else {
                    VStack {
                        HeaderView()
                            .padding(.bottom)
                        
                        SearchBar(text: $searchText, isEditing: $isEditing)
                            .padding(.bottom)
                        
                        ButtonsView(selectedFilter: $selectedFilter)
                            .padding(.bottom)
                        
                        CardsView().padding(.top)
                        
        //                TutorListView()
                    }
                    .padding(.horizontal)
                    .navigationBarHidden(true)
                    .ignoresSafeArea(.all)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TutorView()
            .background(colorBackground)
    }
}
