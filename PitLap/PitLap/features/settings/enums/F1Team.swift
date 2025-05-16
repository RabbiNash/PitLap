//
//  F1Team.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation
import SwiftUI

enum F1Team: String, CaseIterable {
    case redBull, mercedes, ferrari, mclaren, astonMartin, alpine, williams, rb, kick, haas

    var color: Color {
        switch self {
        case .mercedes: return Color(red: 39/255, green: 244/255, blue: 210/255)
        case .redBull: return Color(red: 54/255, green: 113/255, blue: 198/255)
        case .ferrari: return Color(red: 232/255, green: 0/255, blue: 45/255)
        case .mclaren: return Color(red: 255/255, green: 128/255, blue: 0/255)
        case .alpine: return Color(red: 255/255, green: 135/255, blue: 188/255)
        case .rb: return Color(red: 102/255, green: 146/255, blue: 255/255)
        case .astonMartin: return Color(red: 34/255, green: 153/255, blue: 113/255)
        case .williams: return Color(red: 100/255, green: 196/255, blue: 255/255)
        case .kick: return Color(red: 82/255, green: 226/255, blue: 82/255)
        case .haas: return Color(red: 182/255, green: 186/255, blue: 189/255)
        }
    }

    var iconName: String {
        switch self {
        case .redBull: return "Redbull-Icon"
        case .mercedes: return "Mercedes-Icon"
        case .ferrari: return "Ferrari-Icon"
        case .mclaren: return "McLaren-Icon"
        case .astonMartin: return "Aston-Icon"
        case .alpine: return "Alpine-Icon"
        case .williams: return "Williams-Icon"
        case .rb: return "RB-Icon"
        case .kick: return "Kick-Icon"
        case .haas: return "Haas-Icon"
        }
    }

    static let driverAbbreviationToTeam: [String: F1Team] = [
        // Red Bull
        "VER": .redBull,
        "TSU": .redBull,

        // Mercedes
        "ANT": .mercedes,
        "RUS": .mercedes,

        // Ferrari
        "LEC": .ferrari,
        "HAM": .ferrari,

        // McLaren
        "NOR": .mclaren,
        "PIA": .mclaren,

        // Aston Martin
        "ALO": .astonMartin,
        "STR": .astonMartin,

        // Alpine
        "GAS": .alpine,
        "COL": .alpine,

        // Williams
        "ALB": .williams,
        "SAI": .williams,

        // RB (Visa Cash App RB)
        "HAD": .rb,
        "LAW": .rb,

        // Kick Sauber
        "BOR": .kick,
        "HUL": .kick,

        // Haas
        "OCO": .haas,
        "BEA": .haas
    ]

    static func team(for abbreviation: String) -> F1Team? {
        driverAbbreviationToTeam[abbreviation.uppercased()]
    }

    static func color(for abbreviation: String) -> Color {
        team(for: abbreviation)?.color ?? .black // fallback
    }
}

