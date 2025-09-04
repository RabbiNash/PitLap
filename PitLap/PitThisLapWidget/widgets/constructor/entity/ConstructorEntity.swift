//
//  DriverEntity.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//
import Foundation
import AppIntents

struct ConstructorEntity: AppEntity {
    var id: String
    var name: String

    static var defaultQuery = ConstructorQuery()

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Constructor"

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(name)"
        )
    }
}
