//
//  StandingsDataLogic.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation
import PitlapKit

protocol StandingsDataLogicType {
    func getDriverStandings() async -> [DriverStandingModel]
    func getConstructorStandings() async -> [ConstructorStandingModel]
}

final class StandingsDataLogic: StandingsDataLogicType {
    private let service: PitlapService
    
    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }
    
    func getDriverStandings() async -> [DriverStandingModel] {
        await fetchStandings { [self] in try await service.getDriverStandings() }
    }
    
    func getConstructorStandings() async -> [ConstructorStandingModel] {
        await fetchStandings { [self] in try await service.getConstructorStandings() }
    }
    
    private func fetchStandings<T>(operation: @escaping () async throws -> [T]) async -> [T] {
        do {
            return try await operation()
        } catch {
            print("Error loading standings: \(error.localizedDescription)")
            return []
        }
    }
}
