//
//  TriviaCard.swift
//  PitLap
//
//  Created by Tinashe Makuti on 15/04/2025.
//

import SwiftUI

struct TriviaCard: View {
    let level: String
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let progressColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(level)
                .font(.custom("Noto Sans", size: 12))
                .foregroundColor(.gray)

            Image(systemName: icon)
                .font(.custom("Noto Sans", size: 18))
                .foregroundColor(iconColor)
                .padding(12)
                .background(iconColor.opacity(0.1))
                .clipShape(Circle())

            Text(title)
                .styleAsBodyLarge()
                .fontWeight(.semibold)

            Text(subtitle)
                .font(.custom("Noto Sans", size: 14))
                .foregroundColor(.gray)

            Rectangle()
                .frame(height: 4)
                .foregroundColor(progressColor)
                .cornerRadius(2)
        }
        .padding()
        .frame(width: 180)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}
