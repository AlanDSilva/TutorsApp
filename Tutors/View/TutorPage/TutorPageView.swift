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
    @ObservedObject var tutorVM = TutorPageViewModel()
    @State var isEditingLocation: Bool = false
    @State var isEditingDescription: Bool = false
    @State var isEditingSubjects: Bool = false
    @State var isEditingVideo: Bool = false
    
    //MARK: - body
    var body: some View {
        if tutorVM.tutor.id != "" {
            VStack {
                MapView()
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 100)
                    
                CircleImageView()
                    .offset(y: -100)
                    .padding(.bottom, -100)
                    .frame(width: 200, height: 50, alignment: .center)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(tutorVM.tutor.displayName)
                            .font(.title)
                        
                        TutorPageHeadingView(title: "Helsinki", image: "map.fill", isEditing: $isEditingLocation)
                        
                        Divider()
                        
                        Group {
                            TutorPageHeadingView(title: "Description", image: "pencil.circle.fill", isEditing: $isEditingDescription)
                            Text(tutorVM.tutor.description)
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        Group {
                            TutorPageHeadingView(title: "Subjects", image: "plus.circle.fill", isEditing: $isEditingSubjects)
                            SubjectGridView(subjects: $tutorVM.tutor.subjects)
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
                EditDescriptionView(description: tutorVM.tutor.description, tutorVM: tutorVM)
            })
            .sheet(isPresented: $isEditingSubjects, content: {
                EditSubjectsView(subjects: tutorVM.tutor.subjects, tutorVM: tutorVM)
            })
        }
        else {
            Button(action: {
                tutorVM.registerTutor()
            }, label: {
                Text("Click to Register as tutor")
            })
        }
        
        
    }
}

//struct TutorPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorPageView()
//    }
//}
