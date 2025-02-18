//
//  FullWidthSolidButtonStyle.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var backgroundColor: Color = ThemeManager.shared.selectedTeamColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
