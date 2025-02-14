//
//  LapsDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation

protocol LapsDataLogicType {
    func getLaps(year: Int, round: Int, sessionName: String) async -> [GroupedLapModel]
}

final class LapsDataLogic: LapsDataLogicType {

    private let mapper: LapDataMapperType
    private let apiService: ApiService
    
    init(mapper: LapDataMapperType = LapDataMapper(), apiService: ApiService = ApiServiceImpl.shared) {
        self.mapper = mapper
        self.apiService = apiService
    }
    
    func getLaps(year: Int, round: Int, sessionName: String) async -> [GroupedLapModel] {
        do {
            let laps = try await apiService.fetchPracticeLaps(year: year, round: round, sessionName: sessionName).laps
            return mapper.mapToGroupedLapModels(laps: laps)
        } catch {
            print("Error loading laps summary \(error.localizedDescription)")
        }
        return []
    }
}
