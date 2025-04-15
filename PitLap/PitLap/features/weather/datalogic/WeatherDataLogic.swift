//
//  WeatherDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation
import PitlapKit

protocol WeatherDataLogicType {
    func getWeather(year: Int, round: Int) async -> WeatherModel?
}

final class WeatherDataLogic: WeatherDataLogicType {
    private let service: PitlapService
    
    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }
    
    func getWeather(year: Int, round: Int) async -> WeatherModel? {
        do {
            return try await service.getWeather(year: year.asInt32, round: round.asInt32)
        } catch {
            print("Error loading laps summary \(error.localizedDescription)")
        }
        return nil
    }
    
}
