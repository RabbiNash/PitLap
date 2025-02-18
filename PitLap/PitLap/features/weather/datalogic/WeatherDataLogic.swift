//
//  WeatherDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation

protocol WeatherDataLogicType {
    func getWeather(year: Int, round: Int) async -> WeatherModel?
}

final class WeatherDataLogic: WeatherDataLogicType {
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiServiceImpl.shared) {
        self.apiService = apiService
    }
    
    func getWeather(year: Int, round: Int) async -> WeatherModel? {
        do {
            return try await apiService.fetchWeatherSummary(year: year, round: round)
        } catch {
            print("Error loading laps summary \(error.localizedDescription)")
        }
        return nil
    }
    
}
