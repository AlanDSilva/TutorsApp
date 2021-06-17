//
//  SearchBar.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct SearchBar: View {
    //MARK: - properties
    @Binding var text: String
    
    @Binding var isEditing: Bool
    
    //MARK: - body
    var body: some View {
        HStack {
            TextField("Search for tutors ", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .foregroundColor(.gray)
                .background(Color.white)
                .cornerRadius(14)
                .frame(height: 60)
                .overlay(
                    HStack {
                        Spacer()
                        if isEditing {
                            Button(action: {
                                self.text = ""
                                self.isEditing = false
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .padding(.trailing, 8)
                            }
                        }
                        else {
                            Image(systemName: "magnifyingglass")
                                .padding(.trailing, 8)
                        }
                    }
                    
                    .foregroundColor(Color("ColorPink"))
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), isEditing: .constant(false))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackground)

    }
}
