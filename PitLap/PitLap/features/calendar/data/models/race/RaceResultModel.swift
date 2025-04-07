//
//  RaceResultModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 07/04/2025.
//

import Foundation

struct RaceResults: Codable {
    let results: [RaceResultModel]
    
    init(results: [RaceResultModel]) {
        self.results = results
    }
}
