//
//  WeatherSummaryModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation

struct WeatherModel: Codable {
    let year: Int
    let round: Int
    let aiSummary: String
    let condition: String
    let summary: String
    let temperature: Float
    let precipitation: Float
}
