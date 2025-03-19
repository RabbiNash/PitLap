//
//  ThemeManager.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 30/01/2025.
//

import Foundation
import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()

    @AppStorage("selectedTeam") private var selectedTeam: String = F1Team.ferrari.rawValue

    var selectedTeamColor: Color {
        F1Team(rawValue: selectedTeam)?.color ?? .blue
    }
}

extension View {
    func applyAccentColor() -> some View {
        self.tint(ThemeManager.shared.selectedTeamColor)
    }
}
