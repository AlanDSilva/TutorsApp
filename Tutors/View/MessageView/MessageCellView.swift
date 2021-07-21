//
//  MessageCellView.swift
//  Tutors
//
//  Created by Alan on 10.6.2021.
//

import SwiftUI

struct MessageCellView: View {
    @ObservedObject var messageCellVM: MessageCellViewModel
    
    var body: some View {
        if messageCellVM.position {
            if let eventInfo = messageCellVM.eventInfo {
                VStack {
                    Text("Invitation to following event \nDate: \(eventInfo.date)\nStart: \(eventInfo.startTime) \nEnd: \(eventInfo.endTime)")
                    HStack {
                        Button(action: {
                            messageCellVM.removeEvent(of: eventInfo.id!)
                        }, label: {
                            Text("Cancel")
                        })
                        .foregroundColor(.red)
                    }
                }.rightMessageCell()
            } else {
                Text(messageCellVM.message.message).rightMessageCell()
            }
        } else {
            if let eventInfo = messageCellVM.eventInfo {
                VStack {
                    Text("Invitation to following event \nDate: \(eventInfo.date)\nStart: \(eventInfo.startTime) \nEnd: \(eventInfo.endTime)")
                    HStack(spacing: 48) {
                        Button(action: {
                            messageCellVM.removeEvent(of: eventInfo.id!)
                        }, label: {
                            Text("Reject")
                        })
                        .foregroundColor(.red)
                        Button(action: {
                            messageCellVM.acceptEvent(of: eventInfo.id!)
                        }, label: {
                            Text("Accept")
                        })
                        .foregroundColor(.green)
                    }
                }.leftMessageCell()
            } else {
                Text(messageCellVM.message.message).leftMessageCell()
            }
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

struct LeftMessageCell: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
                .padding()
                .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.blue))
            Spacer()
        }
    }
}

struct RightMessageCell: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .padding()
                .background(RoundedRectangle(cornerRadius: 25.0).fill(Color.gray))
        }
    }
}

extension View {
    func leftMessageCell() -> some View {
        modifier(LeftMessageCell())
    }
    func rightMessageCell() -> some View {
        modifier(RightMessageCell())
    }
}
