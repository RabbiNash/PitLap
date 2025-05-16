//
//  SessionTopSpeedViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 16/05/2025.
//

import SwiftUI
import PitlapKit

@MainActor
final class SessionTopSpeedViewModel: ObservableObject {
    
    enum FetchStatus {
        case fetching
        case success
        case failed(message: String)
    }
    
    private(set) var fetchStatus: FetchStatus = .fetching
    
    private let service: PitlapService
    @Published var topSpeeds: [TopSpeedModel] = []

    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }

    func fetchTopSpeeds(year: Int, round: Int, sessionName: String) async {
        fetchStatus = .fetching
        
        do {
            topSpeeds = try await service
                .getSessionTopSpeeds(year: year.asInt32, round: round.asInt32, sessionName: sessionName)
            if topSpeeds.isEmpty {
                fetchStatus = .failed(message: "Top speeds currently unavailable")
            }
        } catch {
            fetchStatus = .failed(message: error.localizedDescription)
        }
                
        fetchStatus = .success
    }
}
