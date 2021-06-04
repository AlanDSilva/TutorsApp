//
//  ChatCellView.swift
//  Tutors
//
//  Created by Alan on 4.6.2021.
//

import SwiftUI

struct ChatCellView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.trailing)
            
            VStack(alignment: .leading){
                Text("First Name")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Here goes the last message")
            }
            
            Spacer()
            
            VStack(alignment: .trailing){
                Text("23:59")
                    .font(.footnote)
                ZStack{
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.pink)
                    Text("1")
                }
            }
        }
    }
}

struct ChatCellView_Previews: PreviewProvider {
    static var previews: some View {
        ChatCellView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
