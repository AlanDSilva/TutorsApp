//
//  HeaderView.swift
//  Tutors
//
//  Created by Alan on 16.6.2021.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good Morning,")
                Text("Full Name")
                    .font(.title3)
                    .padding(.top, 3)
            }
            .foregroundColor(Color("ColorPink"))
            
            Spacer()
            Image("cat3")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        }
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
