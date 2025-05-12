//
//  WeatherEntryCard.swift
//  PitLap
//
//  Created by Tinashe Makuti on 24/04/2025.
//


import SwiftUI
import PitlapKit

struct WeatherEntryCard: View {
    let weather: WeatherModel
    let event: EventScheduleModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            weatherConditionRow
            timeTempRow
            Text(weather.summary)
                .customFont(name: "Noto Sans", size: 14, weight: .semibold)
        }
        .padding(20)
        .background(ThemeManager.shared.selectedTeamColor.opacity(0.5))
        .cornerRadius(16)
        .shadow(radius: 8)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
    }

    private var weatherConditionRow: some View {
        HStack {
            iconLabel(
                systemImage: "sun.max.fill",
                text: weather.condition,
                color: .yellow,
                fontSize: 16
            )
            Spacer()
            Text(event.country)
                .customFont(name: "Noto Sans", size: 16, weight: .semibold)
        }
    }

    private var timeTempRow: some View {
        HStack {
            iconLabel(
                systemImage: "clock",
                text: Date.getCustomFormattedTime(apiDate: event.session5DateUTC ?? "") ?? "",
                color: .gray.opacity(0.7),
                fontSize: 14
            )

            Spacer()

            iconLabel(
                systemImage: "thermometer",
                text: "\(weather.temperature)°C",
                color: .yellow,
                fontSize: 14
            )
        }
    }

    private func iconLabel(systemImage: String, text: String, color: Color, fontSize: CGFloat) -> some View {
        HStack(spacing: 4) {
            Image(systemName: systemImage)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(color)
            Text(text)
                .customFont(name: "Noto Sans", size: fontSize, weight: .semibold)
        }
    }
}
