//
//  ApiRoute.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation

enum APIRoute {
    case schedule
    case driverStandings
    case constructorStandings
    case driverTheoreticalStandings
    case raceSummary(year: Int, round: Int)
    case trackSummary(trackName: String)
    case qualiResults(year: Int, round: Int)
    case laps(year: Int, round: Int, sessionName: String)
    
    var path: String {
        switch self {
        case .schedule:
            return "/schedule"
        case .driverStandings:
            return "/standings/driver"
        case .constructorStandings:
            return "/standings/constructor"
        case .driverTheoreticalStandings:
            return "/standings/driver/theoretical"
        case .raceSummary(let year, let round):
            return "/summary/race/\(year)/\(round)"
        case .trackSummary(let trackName):
            return "/summary/track/\(trackName)"
        case .qualiResults(let year, let round):
            return "/quali/convectional/\(year)/\(round)"
        case .laps(let year, let round, let sessionName):
            return "/practice/\(year)/\(round)/\(sessionName)"
        }
    }
}
