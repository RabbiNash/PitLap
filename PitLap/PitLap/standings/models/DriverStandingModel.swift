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
    let driverCode: String
    let driverURL: String
    let givenName, familyName: String
    let dateOfBirth: Int
    let driverNationality: String
    let constructorIDS: [String]
    let constructorUrls: [String]
    let constructorNames, constructorNationalities: [String]

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case driverID = "driverId"
        case driverNumber, driverCode
        case driverURL = "driverUrl"
        case givenName, familyName, dateOfBirth, driverNationality
        case constructorIDS = "constructorIds"
        case constructorUrls, constructorNames, constructorNationalities
    }
}

struct StandingModel: Codable {
    let standingsTable: [DriverStandingModel]
}
