//
//  TutorPageView.swift
//  Tutors
//
//  Created by Alan on 29.5.2021.
//

import SwiftUI
import MapKit

struct TutorPageView: View {
    //MARK: - properties
    @State var isEditingLocation: Bool = false
    @State var isEditingDescription: Bool = false
    @State var isEditingSubsects: Bool = false
    @State var isEditingVideo: Bool = false
    
    //MARK: - body
    var body: some View {
        VStack {
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 200)
                
            CircleImageView()
                .offset(y: -100)
                .padding(.bottom, -100)
                .frame(width: 200, height: 50, alignment: .center)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Catty McCat")
                        .font(.title)
                    
                    TutorPageHeadingView(title: "Helsinki", image: "map.fill", isEditing: $isEditingLocation)
                    
                    Divider()
                    
                    Group {
                        TutorPageHeadingView(title: "Description", image: "pencil.circle.fill", isEditing: $isEditingDescription)
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque interdum rutrum sodales. Nullam mattis fermentum libero, non volutpat.")
                            .font(.subheadline)
                    }
                    
                    Divider()
                    
                    Group {
                        TutorPageHeadingView(title: "Subjects", image: "plus.circle.fill", isEditing: $isEditingSubsects)
                        SubjectGridView()
                    }
                    
                    Divider()
                    
                    Group {
                        TutorPageHeadingView(title: "Intro Video", image: "video.fill.badge.plus", isEditing: $isEditingVideo)
                        ZStack {
                            Image("cat6")
                                .resizable()
                                .scaledToFit()
                            Image(systemName: "play.circle")
                                .frame(width: 200, height: 200, alignment: .center)
                        }
                    }
                    
                }//: vstack
                .padding()
            }
            
            Spacer()
            
        }//: vstack
        .sheet(isPresented: $isEditingDescription, content: {
            EditDescriptionView()
        })
        
        
    }
}

struct TutorPageView_Previews: PreviewProvider {
    static var previews: some View {
        TutorPageView()
    }
}
