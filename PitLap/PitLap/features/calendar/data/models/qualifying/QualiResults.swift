//
//  QualiResults.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

struct QualiResults: Codable {
    let key: String
    let eventName: String
    let results: [QualiResultModel]
    
    init(key: String, eventName: String, results: [QualiResultModel]) {
        self.key = key
        self.eventName = eventName
        self.results = results
    }
}
