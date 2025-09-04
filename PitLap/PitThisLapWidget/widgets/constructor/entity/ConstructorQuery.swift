//
//  DriverQuery.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//

@preconcurrency import PitlapKit
import AppIntents

struct ConstructorQuery: EntityQuery {
    private let pitlapService = Pitlap.shared.getService()
    
    func entities(for identifiers: [ConstructorEntity.ID]) async throws -> [ConstructorEntity] {
        let standings = try await pitlapService.getConstructorStandings(forceRefresh: true)
        let constructors = standings.map {
            ConstructorEntity(id: $0.constructorId, name: $0.constructorName)
        }
        return constructors.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [ConstructorEntity] {
        let standings = try await pitlapService.getConstructorStandings(forceRefresh: true)
        return standings.map {
            ConstructorEntity(id: $0.constructorId, name: $0.constructorName)
        }
    }
}
