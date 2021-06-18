//
//  TutorDetailView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct TutorDetailView: View {
    //MARK: - properties
    //    @ObservedObject var tutorVM: TutorCellViewModel
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
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(colorPink)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tabSelection: Int = 0
    var body: some View {
        
        ZStack(alignment: .top) {
            colorBackground.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Image("cat6")
                        .resizable()
                        .scaledToFill()
                        .clipShape(CustomShape())
                        .frame(maxHeight: 250)
                    
                    
                    InfoCardView()
                        .offset(y: 5)
                        .padding(.bottom)
                    
                    TabButtonsView(tabSelection: $tabSelection)
                    
                    
                    TabView(selection: $tabSelection) {
                        DescriptionView().tag(0)
                        GalleryView().tag(1)
                        ReviewsView().tag(2)
                    }
                    .padding(20)
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 200)
                    
                    
                    ZStack(alignment: .top) {
                        Color.white.clipShape(CustomShapeTop()).shadow(color: Color.gray, radius: 4.0, x: CGFloat(0.3), y: CGFloat(0.3))
                        
                        HStack {
                            Spacer()
                            Text("Send message")
                                .padding()
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 25).fill(colorPink))
                                .padding()
                        }
                        .padding(.horizontal)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    
                    
                    
                }
                .edgesIgnoringSafeArea(.top)
            }
            .edgesIgnoringSafeArea(.top)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                                    HeaderImage()
                                }))
    }
}


struct TutorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TutorDetailView()
        }
    }
}



struct HeaderImage: View {
    var imgName: String = "arrowtriangle.backward.square.fill"
    var body: some View {
        Image(systemName: imgName)
            .foregroundColor(colorPink)
            .font(.largeTitle)
    }
}
