//
//  RaceResultDataLogicType.swift
//  PitLap
//
//  Created by Tinashe Makuti on 27/03/2025.
//

import Foundation
import PitlapKit

protocol RaceInfoDataLogicType {
    func getResults(year: Int, round: Int) async -> [RaceResultModel]
}

final class RaceInfoDataLogic: RaceInfoDataLogicType {
    private let service: PitlapService
    
    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }
    
    func getResults(year: Int, round: Int) async -> [RaceResultModel] {
        do {
            return try await service.getRaceResults(year: year.asInt32, round: round.asInt32)
        } catch {
            print("Error loading race summary \(error.localizedDescription)")
        }
        return []
    }
}
