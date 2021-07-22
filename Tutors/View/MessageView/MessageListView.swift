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
    @State var showingSheet: Bool = false
    
    var body: some View {
        VStack {
            Text(messageListVM.messageRepo.otherId)
            Text(messageListVM.messageRepo.userId)
            ScrollView {
                ForEach(messageListVM.messageCellVMs) { messageCellVM in
                    MessageCellView(messageCellVM: messageCellVM)
                }
            }
            
            HStack {
                TextField("New Message...", text: $newMessage)
                Button(action: {
                    //                    print("Will send message to \(messageListVM.)")
                    messageListVM.sendMessage(newMessage)
                }, label: {
                    Text("Send")
                })
            }
        }
        .padding(.horizontal)
        .sheet(isPresented: $showingSheet) {
            EventView(eventVM: EventViewModel(chatID: messageListVM.messageRepo.chatId, userID: messageListVM.messageRepo.userId, otherID: messageListVM.messageRepo.otherId))
                }
        .navigationBarItems(
            leading:
                Button(action: {print("Going to go back")}, label: {
                    HeaderImage()
                }),
            trailing:
                Button(action: {showingSheet.toggle()}, label: {
                    HeaderImage(imgName: "plus.square.fill")
                })
        )
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
