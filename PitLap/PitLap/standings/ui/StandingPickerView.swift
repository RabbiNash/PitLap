//
//  StandingPickerView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import SwiftUI

struct StandingPickerView: View {
    @Binding var selectedOption: StandingOption
    var options: [StandingOption] = StandingOption.allCases

    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    withAnimation {
                        selectedOption = option
                    }
                }) {
                    Text(option.title)
                        .font(.system(size: 14, weight: .medium))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedOption == option ? ThemeManager.shared.selectedTeamColor : Color.clear)
                        .foregroundColor(selectedOption == option ? .white : ThemeManager.shared.selectedTeamColor )
                        .overlay(
                            Capsule()
                                .stroke(ThemeManager.shared.selectedTeamColor, lineWidth: selectedOption == option ? 0 : 1)
                        )
                        .clipShape(Capsule())
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(4)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

enum StandingOption: String, CaseIterable {
    case drivers
    case constructors
    
    var title: String {
        switch self {
        case .constructors: return "Constructors"
        case .drivers: return "Drivers"
            
        }
    }
}
