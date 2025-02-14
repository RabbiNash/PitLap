//
//  PracticeLapsModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation

struct PracticeLapsModel: Codable {
    let year: Int
    let round: Int
    let sessionName: String
    let eventFormat: String
    let laps: [LapModel]
    
    init(year: Int, round: Int, sessionName: String, eventFormat: String, laps: [LapModel]) {
        self.year = year
        self.round = round
        self.sessionName = sessionName
        self.eventFormat = eventFormat
        self.laps = laps
    }
}
