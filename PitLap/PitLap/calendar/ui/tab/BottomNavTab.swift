//
//  BottomNavTab.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

enum BottomNavTab: String, CaseIterable {
    case seasons = "Seasons"
    case standings = "Standings"
    case news = "News"
    case trivia = "Trivia"

    var title: String {
        switch self {
        case .seasons:
            return "Season"
        case .standings:
            return "Standings"
        case .trivia:
            return "Trivia"
        case .news:
            return "News"
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
        case .news:
            return "newspaper"
        }
    }
}
