//
//  BottomNavTab.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

enum BottomNavTab: String, CaseIterable {
    case home = "Home"
    case seasons = "Seasons"
    case standings = "Standings"
    case trivia = "Trivia"

    var title: String {
        switch self {
        case .seasons:
            return "Season"
        case .standings:
            return "Standings"
        case .trivia:
            return "Trivia"
        case .home:
            return "Home"
        }
    }

    var icon: String {
        switch self {
        case .seasons:
            return "calendar"
        case .standings:
            return "chart.bar.xaxis"
        case .trivia:
            return "questionmark.circle"
        case .home:
            return "house"
        }
    }
}
