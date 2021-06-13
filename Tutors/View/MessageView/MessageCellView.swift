//
//  MessageCellView.swift
//  Tutors
//
//  Created by Alan on 10.6.2021.
//

import SwiftUI

struct MessageCellView: View {
    var messageCellVM: MessageCellViewModel
    
    var body: some View {
        if messageCellVM.position {
            RightMessageCellView(message: messageCellVM.message)
        } else {
            LeftMessageCellView(message: messageCellVM.message)
        }
        
    }
}

//struct MessageCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageCellView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//        LeftMessageCellView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//        RightMessageCellView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}

struct LeftMessageCellView: View {
    var message: Message
    var body: some View {
        HStack {
            Text(message.message)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.blue))
                
            Spacer()
        }
    }
}

struct RightMessageCellView: View {
    var message: Message
    var body: some View {
        HStack {
            Spacer()
            Text(message.message)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.gray))
        }
    }
}

