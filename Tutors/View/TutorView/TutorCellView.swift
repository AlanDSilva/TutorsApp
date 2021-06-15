//
//  CoverImageView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct TutorCellView: View {
    //MARK: - properties
    @ObservedObject var tutorVM: TutorCellViewModel
    
    //    let tutor: Tutor
    
    //MARK: - body
    var body: some View {
        HStack(spacing: 20){
            if tutorVM.image != nil {
                Image(uiImage: tutorVM.image!)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: 75, height: 75)
                    .padding(.trailing)
                    
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 2)
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 2)
            }
            
            VStack(alignment: .leading) {
                Text(tutorVM.tutor.displayName)
                Text(tutorVM.tutor.subjects[0]).font(.footnote)
                Spacer()
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                    Text("4.2")
                    Image(systemName: "mappin.circle.fill")
                    Text("Helsinki")
                }
                .font(.caption)
            }
            Spacer()
        }
        .padding()
        .frame(height: 100)
        .background(RoundedRectangle(cornerRadius: 16).fill(colorGray))
        .foregroundColor(.primary)
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
