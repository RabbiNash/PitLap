//
//  TrackSummaryModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import Foundation

struct TrackSummaryModel: Codable {
    let track: String
    let fact: String
    let circuitLengthKm: Float
    let firstRace: Int
    
    init(track: String, fact: String, circuitLengthKm: Float, firstRace: Int) {
        self.track = track
        self.fact = fact
        self.circuitLengthKm = circuitLengthKm
        self.firstRace = firstRace
    }
}
