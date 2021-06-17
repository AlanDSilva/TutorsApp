//
//  MainView.swift
//  Tutors
//
//  Created by Alan on 17.5.2021.
//

import SwiftUI

struct MainView: View {
    
    init() {
            UITabBar.appearance().barTintColor = UIColor(colorPink)
        }
    
    var body: some View {
        TabView {
            TutorView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Browse")
                }
            
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
            
            ChatView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Chat")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
        }
        .accentColor(.white)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
