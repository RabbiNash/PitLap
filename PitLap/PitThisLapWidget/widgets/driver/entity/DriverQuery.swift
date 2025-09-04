//
//  DriverQuery.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//

@preconcurrency import PitlapKit
import AppIntents

struct DriverQuery: EntityQuery {
    private let pitlapService = Pitlap.shared.getService()
    
    func entities(for identifiers: [DriverEntity.ID]) async throws -> [DriverEntity] {
        let standings = try await pitlapService.getDriverStandings(forceRefresh: true)
        let drivers = standings.map {
            DriverEntity(id: $0.driverId, givenName: $0.givenName, familyName: $0.familyName)
        }
        return drivers.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [DriverEntity] {
        let standings = try await pitlapService.getDriverStandings(forceRefresh: true)
        return standings.map {
            DriverEntity(id: $0.driverId, givenName: $0.givenName, familyName: $0.familyName)
        }
    }
}
