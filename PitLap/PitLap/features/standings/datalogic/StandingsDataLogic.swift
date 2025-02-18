//
//  StandingsDataLogic.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

protocol StandingsDataLogicType {
    func getDriverStandings() async -> [DriverStandingModel]
    func getConstructorStandings() async -> [ConstructorStandingModel]
}

final class StandingsDataLogic: StandingsDataLogicType {
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiServiceImpl.shared) {
        self.apiService = apiService
    }
    
    func getDriverStandings() async -> [DriverStandingModel] {
        await fetchStandings { [self] in try await apiService.fetchDriverStandings() }
    }
    
    func getConstructorStandings() async -> [ConstructorStandingModel] {
        await fetchStandings { [self] in try await apiService.fetchConstructorStandings() }
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
