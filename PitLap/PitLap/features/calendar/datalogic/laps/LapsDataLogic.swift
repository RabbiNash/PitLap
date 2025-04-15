//
//  LapsDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation
import PitlapKit

protocol LapsDataLogicType {
    func getLaps(year: Int, round: Int, sessionName: String) async -> [GroupedLapModel]
}

final class LapsDataLogic: LapsDataLogicType {

    private let service: PitlapService
    
    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }
    
    func getLaps(year: Int, round: Int, sessionName: String) async -> [GroupedLapModel] {
        do {
            return try await service.getPracticeLaps(year: year.asInt32, round: round.asInt32, sessionName: sessionName)
        } catch {
            print("Error loading laps summary \(error.localizedDescription)")
        }
        return []
    }
}
