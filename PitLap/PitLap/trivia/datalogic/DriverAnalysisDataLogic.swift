//
//  DriverWinDataLogic.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

protocol DriverAnalysisLogicType {
    func getDriverAnalysis() async -> [DriverAnalysisModel]
}

final class DriverAnalysisDataLogic: DriverAnalysisLogicType {
    private let bundle: Bundle
    private let apiService: ApiService

    init(bundle: Bundle = Bundle.main, apiService: ApiService = ApiServiceImpl.shared) {
        self.bundle = bundle
        self.apiService = apiService
    }

    func getDriverAnalysis() async -> [DriverAnalysisModel] {
        do {
            let drivers = try await apiService.fetchDriverTheoreticalStandings()
            return drivers
        } catch {
            print("Error loading driver analysis calendar: \(error.localizedDescription)")
            return []
        }
    }
}

