//
//  TutorDetailView.swift
//  Tutors
//
//  Created by Alan on 18.5.2021.
//

import SwiftUI

struct TutorDetailView: View {
    //MARK: - properties
    //        @ObservedObject var tutorVM: TutorCellViewModel
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
    @State var tabSelection: Int = 0
    var body: some View {
        
        ZStack(alignment: .top) {
            colorBackground.edgesIgnoringSafeArea(.all)
            VStack {
                Image("cat4")
                    .resizable()
                    .scaledToFill()
                    .clipShape(CustomShape())
                
                InfoCardView()
                
                SelectionButtonsView(tabSelection: $tabSelection)
                
                TabView(selection: $tabSelection) {
                    SettingsView().tag(0)
                    GalleryView().tag(1)
                    ReviewsView().tag(2)
                }
                .tabViewStyle(PageTabViewStyle())
                
                
                
                
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Hello, Description")
    }
}

struct GalleryView: View {
    var body: some View {
        Text("Hello, Description")
    }
}

struct ReviewsView: View {
    var body: some View {
        Text("Hello, Description")
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

struct SelectionTextView: View {
    var selectText: String = "Place Description"
    var isSelected: Bool = true
    var body: some View {
        VStack{
            Text(selectText)
            if isSelected {
                Image(systemName: "dot.square")
            }
        }
        .foregroundColor(isSelected ? colorPink : colorGray)
    }
}

struct InfoCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Full Name")
                    .font(.title3)
                Image(systemName: "pin")
                Text("Helsinki")
            }
            HStack {
                Image(systemName: "star")
                Text("3.4")
                Image(systemName: "person.2")
                Text("300")
                Image(systemName: "play")
                Text("2")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.white).shadow(color: Color.gray, radius: 5.0, x: CGFloat(0.7), y: CGFloat(0.3)))
        .offset(y: -60)
        .padding(.bottom, -40)
    }
}


struct TutorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TutorDetailView()
        }
    }
}

struct SelectionButtonsView: View {
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
