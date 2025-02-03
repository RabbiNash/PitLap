//
//  DriverStandingEntity.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation
import SwiftData

@Model
final class DriverStandingEntity {
    var position: Int
    var positionText: String
    var points: Int
    var wins: Int
    var driverID: String
    var driverNumber: Int
    var driverCode: String
    var driverURL: String
    var givenName: String
    var familyName: String
    var dateOfBirth: Int
    var driverNationality: String
    var constructorIDS: [String]
    var constructorUrls: [String]
    var constructorNames: [String]
    var constructorNationalities: [String]

    init(position: Int, positionText: String, points: Int, wins: Int, driverID: String, driverNumber: Int, driverCode: String, driverURL: String, givenName: String, familyName: String, dateOfBirth: Int, driverNationality: String, constructorIDS: [String], constructorUrls: [String], constructorNames: [String], constructorNationalities: [String]) {
        self.position = position
        self.positionText = positionText
        self.points = points
        self.wins = wins
        self.driverID = driverID
        self.driverNumber = driverNumber
        self.driverCode = driverCode
        self.driverURL = driverURL
        self.givenName = givenName
        self.familyName = familyName
        self.dateOfBirth = dateOfBirth
        self.driverNationality = driverNationality
        self.constructorIDS = constructorIDS
        self.constructorUrls = constructorUrls
        self.constructorNames = constructorNames
        self.constructorNationalities = constructorNationalities
    }
}
