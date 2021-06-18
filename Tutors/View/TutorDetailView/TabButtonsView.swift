//
//  TabButtonsView.swift
//  Tutors
//
//  Created by Alan on 18.6.2021.
//

import SwiftUI

struct TabButtonsView: View {
    @Binding var tabSelection: Int
    var body: some View {
        HStack(spacing: 20) {
            ForEach(Selection.allCases) { selection in
                Button(action: {
                    tabSelection = selection.rawValue
                }, label: {
                    SelectionTextView(selectText: selection.getDescription(), isSelected: tabSelection == selection.rawValue)
                })
                
            }
        }
    }
}

struct SelectionTextView: View {
    var selectText: String = "Place Description"
    var isSelected: Bool = true
    var body: some View {
        VStack{
            Text(selectText)
            if isSelected {
                Image(systemName: "dot.square.fill")
            }
        }
        .foregroundColor(isSelected ? colorPink : colorGray)
    }
}

protocol SelectableProtocol {
    var simpleDescription: String {get}
}

enum Selection: Int, CaseIterable, Identifiable, SelectableProtocol {
    case description = 0, gallery, reviews
    
    var id: Int { self.rawValue }
    
    var simpleDescription: String {
        self.getDescription()
    }
    
    func getDescription() -> String {
        switch self {
        case .description: return "Place Description"
        case .gallery: return "Gallery"
        case .reviews: return "Reviews"
        }
    }
}

//struct TabButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabButtonsView(tabSelection: .constant(1))
//    }
//}
