//
//  SessionTopSpeedViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 08/07/2025.
//

import PitlapKit
import SwiftUI

@MainActor
final class RadioViewModel: ObservableObject {
    
    enum FetchStatus {
        case fetching
        case success
        case failed(message: String)
    }
    
    private(set) var fetchStatus: FetchStatus = .fetching
    
    private let service: PitlapService
    @Published var radios: [TeamRadioModel] = []

    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }

    func fetchLatestRadios(driverNumber: Int) async {
        fetchStatus = .fetching
        
        do {
            radios = try await service.getLatestTeamRadio(driverNumber: driverNumber.asInt32)
            if radios.isEmpty {
                fetchStatus = .failed(message: "Radios not available")
            }
        } catch {
            fetchStatus = .failed(message: error.localizedDescription)
        }
                
        fetchStatus = .success
    }
}
