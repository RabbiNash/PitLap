//
//  SettingsView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 30/01/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTeam") private var selectedTeam: String = F1Team.redBull.rawValue

    var body: some View {
        VStack {
            Text("Choose Your F1 Team")
                .font(.headline)

            Picker("Team", selection: $selectedTeam) {
                ForEach(F1Team.allCases, id: \.self) { team in
                    Text(team.rawValue.capitalized).tag(team.rawValue)
                }
            }
            .pickerStyle(.wheel)

            Text("Current Team: \(selectedTeam.capitalized)")
                .padding()
                .foregroundColor(ThemeManager.shared.selectedTeamColor)
        }
        .padding()
    }
}

enum F1Team: String, CaseIterable {
    case redBull, mercedes, ferrari, mclaren, astonMartin, alpine, williams, rb, sauber, haas

    var color: Color {
        switch self {
        case .redBull: return Color(red: 30/255, green: 65/255, blue: 255/255) // Dark Blue
        case .mercedes: return Color(red: 0/255, green: 210/255, blue: 190/255) // Teal
        case .ferrari: return Color(red: 220/255, green: 0/255, blue: 0/255) // Red
        case .mclaren: return Color(red: 255/255, green: 135/255, blue: 0/255) // Papaya Orange
        case .astonMartin: return Color(red: 0/255, green: 111/255, blue: 98/255) // British Racing Green
        case .alpine: return Color(red: 0/255, green: 144/255, blue: 255/255) // Blue
        case .williams: return Color(red: 0/255, green: 82/255, blue: 159/255) // Dark Blue
        case .rb: return Color(red: 76/255, green: 0/255, blue: 130/255) // Purple
        case .sauber: return Color(red: 140/255, green: 0/255, blue: 20/255) // Dark Red
        case .haas: return Color(red: 191/255, green: 191/255, blue: 191/255) // Grey
        }
    }
}


#Preview {
    SettingsView()
}
