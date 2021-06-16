//
//  TutorDetailView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct TutorDetailView: View {
    //MARK: - properties
        @ObservedObject var tutorVM: TutorCellViewModel
    //    let tutor: Tutor
    
    //MARK: - body
    //    var body: some View {
    //        ScrollView(.vertical, showsIndicators: false) {
    //            VStack {
    //                // intro video
    //                Image("cat6")
    //                    .resizable()
    //                    .scaledToFit()
    //
    //                // headline
    //                HeadingView(headingImage: "info.circle", headingText: "Description")
    //                Text(tutorVM.tutor.description)
    //                    .font(.body)
    //                    .multilineTextAlignment(.leading)
    //                    .foregroundColor(.accentColor)
    //                    .padding(.horizontal)
    //
    //
    //            }//: vstack
    //            .navigationBarTitle(tutorVM.tutor.displayName)
    //            .navigationBarItems(trailing:
    //                                    HStack(spacing: 20) {
    //                                        Button(action: {}, label: {
    //                                            Image(systemName: "message")
    //                                        })
    //                                        NavigationLink(destination: MessageView(uId: tutorVM.tutor.id!)) {
    //                                            Image(systemName: "heart")
    //                                        }
    //                                    }
    //                                    .font(.title2)
    //            )
    //
    //
    //        }
    //    }
    var body: some View {
        
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16){
                TutorCardView()
                    .zIndex(1.0)
                    .frame(height: 130)
                    
                
                TitleView2(titleText: "About \(tutorVM.tutor.displayName)")
                
                Text(tutorVM.tutor.description)
                    .lineLimit(4)
                
                
                
                TitleView2(titleText: "Courses by \(tutorVM.tutor.displayName)")
                SubjectGridView(subjects: .constant(tutorVM.tutor.subjects) )
                
                TitleView2(titleText: "Connect")
                HStack{
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.circle")
                    }
                    .foregroundColor(.pink)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "message.circle")
                    }
                    .foregroundColor(.green)
                    
                    
                }
                .font(.system(.title, design: .rounded))
                .imageScale(.large)
                
                
            }
            .padding(.horizontal)
            .background(colorGray
                            .clipShape(CustomShape())
                            .padding(.top, 65)
                            .padding(.bottom, -200)
            )
            
            
        }
        .navigationBarTitle(tutorVM.tutor.displayName)
        
    }
    
}

//struct TutorDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            TutorDetailView()
//        }
//
//    }
//}
