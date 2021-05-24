//
//  LoadingView.swift
//  Tutors
//
//  Created by Alan on 24.5.2021.
//

import SwiftUI

struct LoadingView: View {
    //MARK: - properties
    @State var animation = false
    
    //MARK: - body
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(lineWidth: 7.0)
                .frame(width: 75, height: 75)
                .rotationEffect(.init(degrees: animation ? 360 : 0))
                .padding(50)
        }
        .background(colorGray)
        .cornerRadius(20)
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 1)){
                animation.toggle()
            }
        })
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
