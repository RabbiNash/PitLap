//
//  TrafficLightView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 01/04/2025.
//


import SwiftUI

struct StartLightView: View {
    let isActive: Bool

    var body: some View {
        VStack(spacing: 20) {
            ForEach(0..<3, id: \.self) { _ in
                Circle()
                    .fill(isActive ? ThemeManager.shared.selectedTeamColor : .gray)
                    .frame(width: 50, height: 50)
            }
        }
        .padding()
        .background(Capsule().stroke(Color.white))
        .frame(width: 60, height: 250)
    }
}
