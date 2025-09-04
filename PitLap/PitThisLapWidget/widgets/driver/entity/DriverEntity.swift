//
//  DriverEntity.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//
import Foundation
import AppIntents

struct DriverEntity: AppEntity {
    var id: String
    var givenName: String
    var familyName: String

    static var defaultQuery = DriverQuery()

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Driver"

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(givenName) \(familyName)"
        )
    }
}
