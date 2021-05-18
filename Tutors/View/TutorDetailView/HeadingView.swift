//
//  HeadingView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct HeadingView: View {
    //MARK: - properties
    
    var headingImage: String
    var headingText: String
    
    //MARK: - body
    var body: some View {
        HStack {
            Image(systemName: headingImage)
                .foregroundColor(.accentColor)
                .imageScale(.large)
            
            Text(headingText)
                .font(.title3)
                .fontWeight(.bold)
        }//:hstack
    }
}

struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Photos")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
