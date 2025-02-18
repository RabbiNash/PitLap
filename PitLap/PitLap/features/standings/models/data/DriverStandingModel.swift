//
//  DriverStandingsModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

struct DriverStandingModel: Codable {
    let position: Int
    let positionText: String
    let points, wins: Int
    let driverID: String
    let driverNumber: Int
    let givenName, familyName: String
    let constructorName: String

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case driverID = "driverId"
        case driverNumber
        case givenName, familyName
        case constructorName
    }
}

struct StandingModel: Codable {
    let standingsTable: [DriverStandingModel]
}
