//
//  PracticeLapModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation

struct LapModel: Codable {
    let driver: String
    let headshotUrl: String
    let compound: String
    let lapTime: String
    let lapNumber: Int
    let fullName: String
    
    init(driver: String, headshotUrl: String, compound: String, lapTime: String, lapNumber: Int, fullName: String) {
        self.driver = driver
        self.headshotUrl = headshotUrl
        self.compound = compound
        self.lapTime = lapTime
        self.lapNumber = lapNumber
        self.fullName = fullName
    }
}
