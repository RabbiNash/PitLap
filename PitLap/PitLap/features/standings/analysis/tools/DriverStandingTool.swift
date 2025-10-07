
//
//  FindPointsOfInterestTool.swift
//  PitLap
//
//  Created by Tinashe Makuti on 07/10/2025.
//

import FoundationModels
import SwiftUI
@preconcurrency import PitlapKit

@available(iOS 26.0, *)
struct DriverStandingTool: Tool {
    let name = "findDrivers"
    let description = "Get driver standings for a given season"

    @Generable
    struct Arguments {
        @Guide(description: "The current year")
        let year: Int
    }
    
    func call(arguments: Arguments) async throws -> [String] {
        let drivers: [DriverStandingModel] = try await getDriverStandings(year: arguments.year)
        let formattedDrivers = drivers.map {
            "Family Name:\($0.familyName), Given Name: \($0.givenName), Position: \($0.position), wins: \($0.wins), points: \($0.points)"
        }
        return formattedDrivers
    }
    
    func getDriverStandings(year: Int) async throws -> [DriverStandingModel] {
        try await Pitlap().getService().getDriverStandings(forceRefresh: false)
    }
}
