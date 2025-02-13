//
//  RaceSummaryModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import Foundation

struct RaceSummaryModel: Codable {
    let key: String
    let round: Int
    let name: String
    let year: Int
    let summary: String
    
    init(key: String, round: Int, name: String, year: Int, summary: String) {
        self.key = key
        self.round = round
        self.name = name
        self.year = year
        self.summary = summary
    }
}
