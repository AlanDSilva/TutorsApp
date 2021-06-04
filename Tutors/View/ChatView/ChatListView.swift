//
//  ChatListView.swift
//  Tutors
//
//  Created by Alan on 4.6.2021.
//

import SwiftUI

struct ChatListView: View {
    var body: some View {
        
        List {
            ForEach(0..<5) {_ in
                ChatCellView()
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
