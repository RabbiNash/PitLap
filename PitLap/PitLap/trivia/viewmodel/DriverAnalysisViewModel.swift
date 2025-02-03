//
//  DriverAnalysisViewModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation

final class DriverAnalysisViewModel: ObservableObject {
    private let dataLogic: DriverAnalysisLogicType

    @Published var driverAnalysis: [DriverAnalysisModel] = []

    init(dataLogic: DriverAnalysisLogicType) {
        self.dataLogic = dataLogic
    }

    @MainActor
    func getDriverStandings() async {
        self.driverAnalysis = await dataLogic.getDriverAnalysis()
    }
}
