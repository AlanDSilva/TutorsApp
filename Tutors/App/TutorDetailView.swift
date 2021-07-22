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
    @State var image: UIImage?
    init(tutorVM: TutorCellViewModel) {
        self.tutorVM = tutorVM
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(colorPink)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var tabSelection: Int = 0
    
    //MARK: - body
    var body: some View {
        ZStack(alignment: .top) {
            colorBackground.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    if tutorVM.image != nil {
                        Image(uiImage: tutorVM.image!)
                            .resizable()
                            .clipShape(CustomShape())
                            .frame(height: 255)
                            
                            
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .clipShape(CustomShape())
                            .frame(height: 255)
                            
                    }
                    
                    
                    InfoCardView(displayName: tutorVM.tutor.displayName)
                        .offset(y: -50)
                        .padding(.bottom)
                    
                    TabButtonsView(tabSelection: $tabSelection)
                    
                    
                    TabView(selection: $tabSelection) {
                        DescriptionView(description: tutorVM.tutor.description).tag(0)
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
                            CustomButtonView()
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


//struct TutorDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            TutorDetailView(tutorVM: <#TutorCellViewModel#>)
//        }
//    }
//}


struct HeaderImage: View {
    var imgName: String = "arrowtriangle.backward.square.fill"
    var body: some View {
        Image(systemName: imgName)
            .foregroundColor(colorPink)
            .font(.largeTitle)
    }
}

struct CustomButtonView: View {
    var text: String = "Send message"
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25).fill(colorPink)
                .padding()
            Text(text)
                .padding()
                .foregroundColor(.white)
                .padding()
        }
    }
}
