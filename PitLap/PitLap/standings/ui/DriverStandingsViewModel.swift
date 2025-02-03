//
//  DriverStandingsViewModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

final class DriverStandingsViewModel: ObservableObject {
    private let dataLogic: StandingsDataLogicType

    @Published var driverStandings: [DriverStandingModel] = []

    init(dataLogic: StandingsDataLogicType) {
        self.dataLogic = dataLogic
    }

    @MainActor
    func getDriverStandings() async {
        self.driverStandings = await dataLogic.getDriverStandings()
    }
}
