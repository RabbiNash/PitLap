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
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(maxWidth: 32, maxHeight: 32)
                        .foregroundColor(Color.yellow)
                    Text(weather.condition)
                        .customFont(name: "Noto Sans", size: 16, weight: .semibold)
                }
                Spacer()
                Text(event.country)
            }

            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(maxWidth: 20, maxHeight: 20)
                        .foregroundColor(Color.gray.opacity(0.7))
                    Text(Date.getCustomFormattedTime(apiDate: event.session5DateUTC ?? "") ?? "")
                        .customFont(name: "Noto Sans", size: 14, weight: .semibold)
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "thermometer")
                        .resizable()
                        .frame(maxWidth: 20, maxHeight: 20)
                        .foregroundColor(Color.yellow)
                    
                    Text("\(weather.temperature)°C")
                        .customFont(name: "Noto Sans", size: 14, weight: .semibold)
                }
                Spacer()
            }

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
}
