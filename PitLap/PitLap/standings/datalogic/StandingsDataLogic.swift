//
//  StandingsDataLogic.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

protocol StandingsDataLogicType {
    func getDriverStandings() async -> [DriverStandingModel]
    func loadDriverStandings(completion: @escaping (Bool) -> Void) async
}

final class StandingsDataLogic: StandingsDataLogicType {
    private let mapper: DriverStandingEntityMapper
    private let bundle: Bundle

    init(
        bundle: Bundle = Bundle.main,
        mapper: DriverStandingEntityMapper = DriverStandingEntityMapper()
    ) {
        self.bundle = bundle
        self.mapper = mapper
    }

    func getDriverStandings() async -> [DriverStandingModel] {
        do {
            let standings: StandingModel = try await Bundle.main.decode("f1_standings_2024.json")
            return standings.standingsTable
        } catch {
            print("Error loading season calendar: \(error.localizedDescription)")
            return []
        }
    }

    func loadDriverStandings(completion: @escaping (Bool) -> Void) async {
        do {
            let standings: StandingModel = try await Bundle.main.decode("f1_standings_2024.json")
            let driverStandings = mapper.mapToDriverStandingEntities(standings.standingsTable)
        } catch {
            print("Error loading season calendar: \(error.localizedDescription)")
        }
    }
}
