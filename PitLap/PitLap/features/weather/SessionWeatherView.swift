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
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                if let weather = viewModel.weather {
                    HStack {
                        Image(systemName: "cloud.drizzle")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text(viewModel.weather?.summary ?? "")
                        .font(.custom("Audiowide", size: 64))
                        .minimumScaleFactor(0.5)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Divider()
                        .frame(height: 2)
                        .overlay(Color.white)
                    
                    HStack(spacing: 16) {
                        Spacer()
                        
                        Divider()
                            .frame(width: 2, height: 64)
                            .overlay(Color.white)
                        
                        HStack {
                            Image(systemName: "thermometer.sun")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .padding(4)
                            
                            Text("\(weather.temperature)°C")
                                .font(.custom("Noto Sans", size: 32))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                        
                        Divider()
                            .frame(width: 2, height: 64)
                            .overlay(Color.white)
                        
                        HStack {
                            Image(systemName: "cloud.drizzle")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.white)
                                .padding(4)
                            
                            Text("\(weather.precipitation) mm")
                                .font(.custom("Noto Sans", size: 32))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(height: 48)
                    .padding(.top)
                    .padding(.bottom, 32)
                }
                    
                }
                    .padding(24)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        let startColor = isDarkMode ? Color.black : Color.white
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
                                    colors: [
                                        startColor,
                                        ThemeManager.shared.selectedTeamColor.opacity(0.5),
                                        ThemeManager.shared.selectedTeamColor,
                                        ThemeManager.shared.selectedTeamColor,
                                        ThemeManager.shared.selectedTeamColor.opacity(0.5),
                                        ThemeManager.shared.selectedTeamColor,
                                        ThemeManager.shared.selectedTeamColor,
                                        ThemeManager.shared.selectedTeamColor.opacity(0.5),
                                        ThemeManager.shared.selectedTeamColor,
                                        ThemeManager.shared.selectedTeamColor
                                    ]
                                )
                            }.edgesIgnoringSafeArea(.all)
                        } else {
                            RoundedRectangle(cornerRadius: 0)
                                .fill(ThemeManager.shared.selectedTeamColor.gradient)
                                .edgesIgnoringSafeArea(.all)
                            
                        }
                    }.onAppear {
                        viewModel.viewDidAppear(year: year, round: round)
                    }
        }
    }
}
