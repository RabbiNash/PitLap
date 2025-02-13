//
//  SeasonTabItems.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 20/01/2025.
//

import Foundation

enum SeasonTabOption: String, CaseIterable {
    case first
    case second

    var title: String {
        switch self {
        case .first: return "2025"
        case .second: return "2024"
        }
    }
}
