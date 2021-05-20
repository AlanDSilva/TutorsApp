//
//  CoverImageView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct CardView: View {
    //MARK: - properties
    @ObservedObject var tutorVM: TutorViewModel
    
//    let tutor: Tutor
    
    //MARK: - body
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: radius).fill(Color.white)
            RoundedRectangle(cornerRadius: radius).stroke(colorGray)
            
            VStack {
                Image(tutorVM.tutor.photoURL)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                
                Text(tutorVM.tutor.name)
                    .font(.title3)
                
                Text(tutorVM.tutor.subject)
                    .font(.body)
                    .fontWeight(.light)
                
                HStack {
                    Image(systemName: "star.fill")
                    Text("3.5")
                    
                    Spacer()
                    
                    Image(systemName: "heart")
                        
                } //: hstack
                .font(.title3)
                
            }//: vstack
            .padding()
            .foregroundColor(.black)
        }
    }
}

//struct CoverImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(tutor: Tutor.data[2])
//            .previewLayout(.sizeThatFits)
//            .padding()
//            .background(colorBackground)
//
//
//    }
//}
