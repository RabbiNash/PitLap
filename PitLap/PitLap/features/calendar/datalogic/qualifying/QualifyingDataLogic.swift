//
//  QualiDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import PitlapKit

protocol QualifyingDataLogicType {
    func getQualiResults(year: Int, round: Int) async -> [QualifyingResultModel]
}

final class QualifyingDataLogic: QualifyingDataLogicType {
    
    private let pitlapService: PitlapService
    
    init(pitlapService: PitlapService = Pitlap.shared.getService()) {
        self.pitlapService = pitlapService
    }
    
    func getQualiResults(year: Int, round: Int) async -> [QualifyingResultModel] {
        do {
            return try await pitlapService.getQualifyingResults(year: year.asInt32, round: round.asInt32)
        } catch {
            print("Error loading qualifying results \(error.localizedDescription)")
        }
        return []
    }
}
