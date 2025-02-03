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

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }

    func getDriverAnalysis() async -> [DriverAnalysisModel] {
        do {
            let drivers: DriversWinModel = try await Bundle.main.decode("drivers_win_analysis.json")
            return drivers.drivers
        } catch {
            print("Error loading season calendar: \(error.localizedDescription)")
            return []
        }
    }
}

