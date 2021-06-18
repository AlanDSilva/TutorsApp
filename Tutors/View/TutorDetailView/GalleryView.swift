//
//  GalleryView.swift
//  Tutors
//
//  Created by Alan on 18.6.2021.
//

import SwiftUI

struct GalleryView: View {
    var gallery: [String] = ["cat3", "cat4"]
    var body: some View {
        HStack {
            ForEach(gallery, id: \.self) { item in
                GalleryCellView(video: item)
            }
        }
    }
}

struct GalleryCellView: View {
    var video: String = "cat5"
    var body: some View {
        ZStack {
            Image(video)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 150)
            Image(systemName: "play.circle")
                .font(.title)
                .padding(2)
                .background(RoundedRectangle(cornerRadius: 10.0).fill(colorGray))
            
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
