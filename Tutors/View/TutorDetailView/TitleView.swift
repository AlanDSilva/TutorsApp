//
//  TitleView.swift
//  Tutors
//
//  Created by Alan on 15.6.2021.
//

import SwiftUI

struct TitleView: View {
    var titleText: String
    
    var body: some View {
        Text(titleText)
            .font(.title2)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
