//
//  CardsView.swift
//  Tutors
//
//  Created by Alan on 16.6.2021.
//

import SwiftUI

struct CardsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended Tutors")
                .fontWeight(.bold)
                .foregroundColor(colorPink)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    CardView()
                    CardView()
                    CardView()
                }
            }
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}

struct CardView: View {
    var body: some View {
        VStack(alignment: .leading){
            Image("cat7")
                .resizable()
            VStack(alignment: .leading)  {
                Text("Full Name")
                    .fontWeight(.semibold)
                Text("Maths and Geography")
                    .font(.footnote)
            }
            .foregroundColor(colorPink)
            .padding()
        }
        .frame(width: 180, height: 240)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.gray,
                radius: 5.0,
                x: CGFloat(0.7),
                y: CGFloat(0.3))
    }
}
