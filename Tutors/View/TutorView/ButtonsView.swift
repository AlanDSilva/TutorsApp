//
//  Buttons.swift
//  Tutors
//
//  Created by Alan on 16.6.2021.
//

import SwiftUI

struct ButtonsView: View {
    @State private var selectedFilter = Filter.recent
    var body: some View {
        
        HStack(spacing: 20) {
            ForEach(Filter.allCases) { filter in
                Button(action: {
                    selectedFilter = filter
                }, label: {
                    ButtonView(selected: selectedFilter == filter, buttonImg: getFilterImg(from: filter), buttonText: filter.rawValue.capitalized)
                })
                
            }
        }
        
    }
}

struct ButtonView: View {
    var selected: Bool = false
    var buttonImg: String = "clock"
    var buttonText: String = "Recent"
    
    
    var body: some View {
        if selected {
            VStack {
                Image(systemName: buttonImg)
                    .foregroundColor(.white)
                    .padding()
                    .background(colorPink.cornerRadius(14))
                
                Text(buttonText)
                    .foregroundColor(colorPink)
                    .font(.footnote)
            }
        } else {
            VStack {
                Image(systemName: buttonImg)
                    .foregroundColor(.gray)
                    .padding()
                    .background(Color.white.cornerRadius(14))
                
                Text(buttonText)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
        }
    }
}



enum Filter: String, CaseIterable, Identifiable {
    case recent
    case trending
    case popular
    case premium
    
    var id: String { self.rawValue }
}

func getFilterImg(from filter: Filter) -> String {
    switch filter {
    case .recent:
        return "clock"
    case .trending:
        return "flame"
    case .popular:
        return "crown"
    case .premium:
        return "diamond"
    }
}


struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView()
            .background(colorBackground)
        ButtonView()
        
    }
}
