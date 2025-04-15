//
//  RaceResultViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 27/03/2025.
//

import Foundation
import PitlapKit

final class RaceResultViewModel: ObservableObject {
    private let dataLogic: RaceInfoDataLogicType
    
    @Published var isLoading: Bool = false
    @Published var results: [RaceResultModel] = []

    init(dataLogic: RaceInfoDataLogicType = RaceInfoDataLogic()) {
        self.dataLogic = dataLogic
    }

    func viewDidAppear(year: Int, round: Int) {
        Task {
            await fetchRaceResult(year: year, round: round)
        }
    }
    
    @MainActor
    private func fetchRaceResult(year: Int, round: Int) async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        results = await self.dataLogic.getResults(year: year, round: round).sorted { $0.position < $1.position }
    }
}
