//
//  ChatListView.swift
//  Tutors
//
//  Created by Alan on 4.6.2021.
//

import SwiftUI

struct ChatListView: View {
    @ObservedObject var chatListVM = ChatListViewModel()
    
    var body: some View {
        List {
            ForEach(chatListVM.chatCellVMs) { chatCellVM in
                    ChatCellView(chatCellVM: chatCellVM)
            }
        }
    }
}

//struct ChatListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatListView()
//    }
//}
