//
//  DeterminateProgressView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 25/04/2025.
//

import SwiftUI

struct DeterminateProgressView: View {
    var progress: CGFloat

    var body: some View {
        Capsule()
            .frame(height: 3)
            .foregroundColor(ThemeManager.shared.selectedTeamColor)
            .overlay(progressBar)
    }

    private var progressBar: some View {
        GeometryReader { geometry in
            Capsule()
                .foregroundColor(Color(
                    red: 232.0 / 255,
                    green: 232.0 / 255,
                    blue: 232.0 / 255
                ))
                .frame(width: geometry.size.width * progress)
                .animation(.linear(duration: 0.2), value: progress)
        }
    }
}
