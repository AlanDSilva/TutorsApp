//
//  MessageView.swift
//  Tutors
//
//  Created by Alan on 13.6.2021.
//

import SwiftUI

struct MessageView: View {
    var uId: String
    var body: some View {
        MessageListView(messageListVM: MessageListViewModel(uId))
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//    }
//}
