//
//  TrackMapView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 08/10/2025.
//

import SwiftUI
import MapKit
import PitlapKit

struct TrackMapView: View {
    @Environment(\.dismiss) var dismiss
    
    private let eventScheduleModel: EventScheduleModel
    
    init(eventScheduleModel: EventScheduleModel) {
        self.eventScheduleModel = eventScheduleModel
    }
    
    var body: some View {
         ZStack(alignment: .topTrailing) {
             mapView
                 .ignoresSafeArea()
             
             Button(action: { dismiss() }) {
                 Image(systemName: "xmark.circle")
                     .resizable()
                     .frame(width: 30, height: 30)
                     .tint(.primary)
                     .padding(8)
                     .background(.ultraThinMaterial, in: Circle())
             }
             .padding(.trailing, 16)
             .padding(.top, 16)
         }
         .sheet(isPresented: .constant(true)) {
             RaceWeekendHeaderView(event: eventScheduleModel, showMap: false)
                 .padding(24)
                 .presentationDetents([.fraction(0.3), .fraction(0.4)])
                 .presentationBackgroundInteraction(.enabled)
                 .interactiveDismissDisabled()
         }
     }
    
    @ViewBuilder
    private var mapView: some View {
        Map(initialPosition: .region(getTrackCoordinateRegion(round: Int(eventScheduleModel.round))))
            .mapStyle(.standard)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Rectangle()
                  .foregroundStyle(.clear)
                  .frame(height: 80)
            }
    }
    
    private func getTrackCoordinateRegion(round: Int) -> MKCoordinateRegion {
        let regionByRound: [Int: MKCoordinateRegion] = [
            1: .bahrain,
            2: .jeddah,
            3: .melbourne,
            4: .suzuka,
            5: .shanghai,
            6: .miami,
            7: .imola,
            8: .monaco,
            9: .barcelona,
            10: .montreal,
            11: .redBullRing,
            12: .silverstone,
            13: .hungaroring,
            14: .spa,
            15: .zandvoort,
            16: .monza,
            17: .baku,
            18: .singapore,
            19: .cota,
            20: .mexicoCity,
            21: .interlagos,
            22: .lasVegas,
            23: .lusail,
            24: .yasMarina
        ]
        
        return regionByRound[round] ?? .yasMarina
    }

}


import MapKit

extension MKCoordinateRegion {
    static let bahrain = MKCoordinateRegion(
        center: .init(latitude: 26.0325, longitude: 50.5106),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let jeddah = MKCoordinateRegion(
        center: .init(latitude: 21.6333, longitude: 39.1044),
        latitudinalMeters: 10000,
        longitudinalMeters: 10000
    )
    
    static let melbourne = MKCoordinateRegion(
        center: .init(latitude: -37.847345, longitude: 144.970225),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let suzuka = MKCoordinateRegion(
        center: .init(latitude: 34.8431, longitude: 136.5416),
        latitudinalMeters: 6000,
        longitudinalMeters: 6000
    )
    
    static let shanghai = MKCoordinateRegion(
        center: .init(latitude: 31.3389, longitude: 121.22),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let miami = MKCoordinateRegion(
        center: .init(latitude: 25.9581, longitude: -80.2389),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let imola = MKCoordinateRegion(
        center: .init(latitude: 44.3439, longitude: 11.7161),
        latitudinalMeters: 6000,
        longitudinalMeters: 6000
    )
    
    static let monaco = MKCoordinateRegion(
        center: .init(latitude: 43.7376, longitude: 7.4246),
        latitudinalMeters: 3000,
        longitudinalMeters: 3000
    )
    
    static let barcelona = MKCoordinateRegion(
        center: .init(latitude: 41.5700, longitude: 2.2610),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let montreal = MKCoordinateRegion(
        center: .init(latitude: 45.5040, longitude: -73.5563),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let redBullRing = MKCoordinateRegion(
        center: .init(latitude: 47.2197, longitude: 14.7647),
        latitudinalMeters: 6000,
        longitudinalMeters: 6000
    )
    
    static let silverstone = MKCoordinateRegion(
        center: .init(latitude: 52.0700, longitude: -1.1364),
        latitudinalMeters: 40000,
        longitudinalMeters: 40000
    )
    
    static let hungaroring = MKCoordinateRegion(
        center: .init(latitude: 47.5789, longitude: 19.2486),
        latitudinalMeters: 5000,
        longitudinalMeters: 5000
    )
    
    static let spa = MKCoordinateRegion(
        center: .init(latitude: 50.4357, longitude: 5.9695),
        latitudinalMeters: 12000,
        longitudinalMeters: 12000
    )
    
    static let zandvoort = MKCoordinateRegion(
        center: .init(latitude: 52.3888, longitude: 4.5408),
        latitudinalMeters: 6000,
        longitudinalMeters: 6000
    )
    
    static let monza = MKCoordinateRegion(
        center: .init(latitude: 45.6156, longitude: 9.2810),
        latitudinalMeters: 6000,
        longitudinalMeters: 6000
    )
    
    static let baku = MKCoordinateRegion(
        center: .init(latitude: 40.3725, longitude: 49.8533),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let singapore = MKCoordinateRegion(
        center: .init(latitude: 1.2910, longitude: 103.8648),
        latitudinalMeters: 6000,
        longitudinalMeters: 6000
    )
    
    static let cota = MKCoordinateRegion(
        center: .init(latitude: 30.13661, longitude: -97.630692),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let mexicoCity = MKCoordinateRegion(
        center: .init(latitude: 19.4042, longitude: -99.0838),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let interlagos = MKCoordinateRegion(
        center: .init(latitude: -23.7010, longitude: -46.6997),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let lasVegas = MKCoordinateRegion(
        center: .init(latitude: 36.1699, longitude: -115.1398),
        latitudinalMeters: 6000,
        longitudinalMeters: 6000
    )
    
    static let lusail = MKCoordinateRegion(
        center: .init(latitude: 25.3819, longitude: 51.5315),
        latitudinalMeters: 8000,
        longitudinalMeters: 8000
    )
    
    static let yasMarina = MKCoordinateRegion(
        center: .init(latitude: 24.4672, longitude: 54.6031),
        latitudinalMeters: 6000,
        longitudinalMeters: 6000
    )
}
