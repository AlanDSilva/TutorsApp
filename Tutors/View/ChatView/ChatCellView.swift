//
//  ChatCellView.swift
//  Tutors
//
//  Created by Alan on 4.6.2021.
//

import SwiftUI

struct ChatCellView: View {
    @ObservedObject var chatCellVM: ChatCellViewModel
    
    var body: some View {
        HStack {
            if(chatCellVM.image != nil) {
                Image(uiImage: chatCellVM.image!)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding(.trailing)
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding(.trailing)
            }
            
            VStack(alignment: .leading){
                Text(chatCellVM.otherUser.displayName)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(chatCellVM.message)
                Text(chatCellVM.dateString)
                    .font(.footnote)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                ZStack{
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.pink)
                    Text("1")
                }
            }
        }
        .onAppear{
            chatCellVM.loadImage()
        }
        
    }
}

//struct ChatCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatCellView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
