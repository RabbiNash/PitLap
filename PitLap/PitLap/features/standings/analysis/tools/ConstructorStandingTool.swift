//
//  FindNearbyPointsOfInterestTool.swift
//  PitLap
//
//  Created by Tinashe Makuti on 07/10/2025.
//


import Foundation
import FoundationModels
@preconcurrency import PitlapKit

@available(iOS 26.0, *)
struct ConstructorDataTool: Tool {
    let name = "findConstructors"
    let description = "Gets the constructor standings from the database"

    @Generable
    struct Arguments {
        @Guide(description: "The current year")
        let year: Int
    }


    func call(arguments: Arguments) async throws -> [String] {
        let constructor: [ConstructorStandingModel] = try await getConstructorStandings(year: arguments.year)
        let formattedConstructors = constructor.map {
            "\($0.constructorName) \($0.position) \($0.points)"
        }
        return formattedConstructors
    }
    
    func getConstructorStandings(year: Int) async throws -> [ConstructorStandingModel] {
        try await Pitlap().getService().getConstructorStandings(forceRefresh: false)
    }
}
