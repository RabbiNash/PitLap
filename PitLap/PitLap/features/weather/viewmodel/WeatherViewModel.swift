//
//  WeatherViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    private let dataLogic: WeatherDataLogicType
    
    @Published var isLoading: Bool = false
    @Published var weather: WeatherModel? = nil

    init(dataLogic: WeatherDataLogicType = WeatherDataLogic()) {
        self.dataLogic = dataLogic
    }

    func viewDidAppear(year: Int, round: Int) {
        Task {
            await fetchWeather(year: year, round: round)
        }
    }
    
    @MainActor
    private func fetchWeather(year: Int, round: Int) async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        weather = await self.dataLogic.getWeather(year: year, round: round)
    }
}
