//
//  MapView.swift
//  Tutors
//
//  Created by Alan on 29.5.2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    //MARK: - properties
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    
    //MARK: - body
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
