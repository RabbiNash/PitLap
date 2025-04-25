//
//  DriverStandingsViewModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation
import PitlapKit

final class StandingsViewModel: ObservableObject {
    private let dataLogic: StandingsDataLogicType
    
    @Published var isLoading: Bool = false
    @Published var standings: [StandingRowModel] = []
    
    init(dataLogic: StandingsDataLogicType) {
        self.dataLogic = dataLogic
    }
    
    func getDriverStandings(forceRefresh: Bool) async {
        await fetchStandings { [self] in await dataLogic.getDriverStandings(forceRefresh: forceRefresh).map { StandingRowModel(from: $0) } }
    }
    
    func getConstructorStandings(forceRefresh: Bool) async {
        await fetchStandings { [self] in await dataLogic.getConstructorStandings(forceRefresh: forceRefresh).map { StandingRowModel(from: $0) } }
    }
    
    @MainActor
    private func fetchStandings(_ operation: @escaping () async -> [StandingRowModel]) async {
        isLoading = true
        defer { isLoading = false }
        self.standings = await operation()
    }
}

extension StandingRowModel {
    init(from standing: DriverStandingModel) {
        self.init(
            position: standing.positionText,
            fullName: "\(standing.givenName) \(standing.familyName)",
            constructorName: standing.constructorName,
            points: "\(standing.points)",
            wins: "\(standing.wins)"
        )
    }
    
    init(from standing: ConstructorStandingModel) {
        self.init(
            position: standing.positionText,
            fullName: nil,
            constructorName: standing.constructorName,
            points: "\(standing.points)",
            wins: "\(standing.wins)"
        )
    }
}
