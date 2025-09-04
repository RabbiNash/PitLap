//
//  TeamRadioDataLogicType.swift
//  PitLap
//
//  Created by Tinashe Makuti on 08/07/2025.
//

import Foundation
import PitlapKit

protocol TeamRadioDataLogicType {
    func getLatestTeamRadio(driverNumber: Int) async -> [TeamRadioModel]
}

final class TeamRadioDataLogic: TeamRadioDataLogicType {
    
    private let service: PitlapService
    
    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }
    
    func getLatestTeamRadio(driverNumber: Int) async -> [TeamRadioModel] {
        do {
            return try await service.getLatestTeamRadio(driverNumber: driverNumber.asInt32)
        } catch {
            print("Error loading race summary \(error.localizedDescription)")
        }
        return []
    }
}
