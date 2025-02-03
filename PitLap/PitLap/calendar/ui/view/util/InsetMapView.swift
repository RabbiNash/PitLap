//
//  InsetMapView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 31/12/2024.
//

import SwiftUI
import MapKit

struct InsetMapView: View {

    private let weekend: RaceWeekend

    init(weekend: RaceWeekend) {
        self.weekend = weekend
    }

    @State private var region: MKCoordinateRegion = .init()

    var body: some View {
        Text("")
//        Map(coordinateRegion: $region, annotationItems: [weekend]) { weekend in
//                 MapMarker(coordinate: CLLocationCoordinate2D(latitude: weekend.latitude, longitude: weekend.longitude), tint: .blue)
//             }
//            .frame(height: 256)
//            .cornerRadius(12)
//            .onAppear {
//                region = MKCoordinateRegion(
//                    center: CLLocationCoordinate2D(latitude: weekend.latitude, longitude: weekend.longitude),
//                    span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
//                )
//            }
    }
}
