//
//  QualiViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation
import PitlapKit

final class QualifyingViewModel: ObservableObject {
    private let dataLogic: QualifyingDataLogicType
    
    @Published var isLoading: Bool = false
    @Published var results: [QualifyingResultModel] = []

    init(dataLogic: QualifyingDataLogicType = QualifyingDataLogic()) {
        self.dataLogic = dataLogic
    }

    func viewDidAppear(year: Int, round: Int) {
        Task {
            await fetchQualiResults(year: year, round: round)
        }
    }
    
    @MainActor
    private func fetchQualiResults(year: Int, round: Int) async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        results = await self.dataLogic.getQualiResults(year: year, round: round)
    }
}
