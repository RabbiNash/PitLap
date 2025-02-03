//
//  DriverWinModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

struct DriverAnalysisModel: Codable {
    let id = UUID()
    let position: Int
    let name: String
    let currentPoints, theoreticalMaxPoints: Int
    let canWin: String

    enum CodingKeys: String, CodingKey {
        case position, name
        case currentPoints = "current_points"
        case theoreticalMaxPoints = "theoretical_max_points"
        case canWin = "can_win"
    }
}

struct DriversWinModel: Codable {
    let drivers: [DriverAnalysisModel]
}
