//
//  SeasonTabItems.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 20/01/2025.
//

import Foundation

enum SeasonTabOption: String, CaseIterable {
    case current
    case previous

    var title: String {
        switch self {
        case .current: return "2025"
        case .previous: return "2024"
        }
    }
}
