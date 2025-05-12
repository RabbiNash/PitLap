//
//  SessionWeatherView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import SwiftUI
import PitlapKit

struct SessionWeatherView: View {
    @StateObject private var viewModel: WeatherViewModel
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    private let round: Int
    private let year: Int

    init(viewModel: WeatherViewModel = WeatherViewModel(), round: Int, year: Int) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.round = round
        self.year = year
    }
    
    var body: some View {
        ZStack {
            backgroundView
            content
                .padding(24)
        }
        .onAppear {
            viewModel.viewDidAppear(year: year, round: round)
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Spacer()
            
            if let weather = viewModel.weather {
                weatherIcon(for: weather)
                
                Text(weather.summary)
                    .styleAsDisplayHero()
                    .minimumScaleFactor(0.5)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Spacer()
                
                Divider()
                    .frame(height: 2)
                    .overlay(Color.white)
                
                weatherStats(for: weather)
                    .padding(.vertical, 16)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func weatherIcon(for weather: WeatherModel) -> some View {
        HStack {
            Image(systemName: weather.precipitation > 0 ? "cloud.drizzle" : "sun.max.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundStyle(.white)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func weatherStats(for weather: WeatherModel) -> some View {
        HStack(spacing: 16) {
            Spacer()
            
            weatherStatView(
                systemImage: "thermometer.sun",
                value: weather.temperature,
                suffix: "°C"
            )
            
            Divider()
                .frame(width: 2, height: 64)
                .overlay(Color.white)
            
            weatherStatView(
                systemImage: "cloud.drizzle",
                value: weather.precipitation,
                suffix: "mm"
            )
        }
        .frame(height: 64)
    }
    
    private func weatherStatView(systemImage: String, value: Float, suffix: String) -> some View {
        HStack {
            Image(systemName: systemImage)
                .resizable()
                .frame(width: 32, height: 32)
                .scaledToFit()
                .foregroundStyle(.white)
                .padding(4)
            
            Text("\(String(format: "%.1f", value)) \(suffix)")
                .styleAsDisplaySmall()
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        let baseColor = isDarkMode ? Color.black : Color.white
        if #available(iOS 18.0, *) {
            TimelineView(.animation) { timeline in
                let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 2
                MeshGradient(
                    width: 3, height: 3,
                    points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [Float(x), 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ],
                    colors: Array(repeating: ThemeManager.shared.selectedTeamColor, count: 9)
                        .enumerated()
                        .map { index, color in
                            index.isMultiple(of: 2) ? color.opacity(0.5) : color
                        }
                )
            }
        } else {
            RoundedRectangle(cornerRadius: 0)
                .fill(ThemeManager.shared.selectedTeamColor.gradient)
        }
    }
}
