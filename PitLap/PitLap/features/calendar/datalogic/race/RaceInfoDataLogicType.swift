//
//  RaceResultDataLogicType.swift
//  PitLap
//
//  Created by Tinashe Makuti on 27/03/2025.
//

import Foundation

protocol RaceInfoDataLogicType {
    func getResults(year: Int, round: Int) async -> [RaceResultModel]
}

final class RaceInfoDataLogic: RaceInfoDataLogicType {
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiServiceImpl.shared) {
        self.apiService = apiService
    }
    
    func getResults(year: Int, round: Int) async -> [RaceResultModel] {
        do {
            return try await apiService.fetchRaceResult(year: year, round: round)
        } catch {
            print("Error loading race summary \(error.localizedDescription)")
        }
        return []
    }
    
}
