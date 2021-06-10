//
//  ChatView.swift
//  Tutors
//
//  Created by Alan on 17.5.2021.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationView {
            ChatListView()
                .navigationBarTitle("Chats")
        }
        
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
