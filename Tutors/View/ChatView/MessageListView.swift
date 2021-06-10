//
//  MessageListView.swift
//  Tutors
//
//  Created by Alan on 9.6.2021.
//

import SwiftUI

struct MessageListView: View {
    
    @ObservedObject var messageListVM: MessageListViewModel
    @State var newMessage: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(messageListVM.messages) { message in
                    MessageCellView(message: message)
                }
            }
            
            HStack {
                TextField("New Message...", text: $newMessage)
                Button(action: {
                    print("Will send message to \(messageListVM.messages)")
                    messageListVM.sendMessage(newMessage)
                }, label: {
                    Text("Send")
                })
            }
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
