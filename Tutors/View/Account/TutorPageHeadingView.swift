//
//  TutorPageHeadingView.swift
//  Tutors
//
//  Created by Alan on 29.5.2021.
//

import SwiftUI

struct TutorPageHeadingView: View {
    //MARK: - properties
    let title: String
    let image: String
    
    @Binding var isEditing: Bool
    
    //MARK: - body
    var body: some View {
        HStack {
            Text(title)
                .font(.title3)
            Spacer()
            Button(action: {}){
                Image(systemName: image)
            }
        }
    }
}

//struct TutorPageHeadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorPageHeadingView()
//    }
//}
