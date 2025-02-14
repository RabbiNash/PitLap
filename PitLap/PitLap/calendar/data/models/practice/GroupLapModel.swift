//
//  GroupLapModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation

struct GroupedLapModel: Codable {
    let driver: String
    let fullName: String
    let headshotUrl: String
    let compoundLaps: [CompoundLaps]
    let bestLapTime: String
    
    init(driver: String, fullName: String, headshotUrl: String, compoundLaps: [CompoundLaps], bestLapTime: String) {
        self.driver = driver
        self.fullName = fullName
        self.headshotUrl = headshotUrl
        self.compoundLaps = compoundLaps
        self.bestLapTime = bestLapTime
    }
}

struct CompoundLaps: Codable {
    let compound: String
    let laps: [LapModel]
}
