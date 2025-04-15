//
//  RaceSummaryDataLogicType.swift
//  PitLap
//
//  Created by Tinashe Makuti on 15/04/2025.
//

import PitlapKit

protocol RaceSummaryDataLogicType {
    func fetchRaceSummary(round: Int, year: Int) async -> RaceSummaryModel?
    func fetchTrackFacts(trackName: String) async -> TrackSummaryModel?
}

final class RaceSummaryDataLogic: RaceSummaryDataLogicType {
    
    private let pitlapService: PitlapService
    
    init(pitlapService: PitlapService = Pitlap.shared.getService()) {
        self.pitlapService = pitlapService
    }
    
    func fetchRaceSummary(round: Int, year: Int) async -> RaceSummaryModel? {
        do {
            return try await pitlapService.getRaceSummary(year: year.asInt32, round: round.asInt32)
        } catch {
            print("Error loading race summary \(error.localizedDescription)")
        }
        return nil
    }
    
    func fetchTrackFacts(trackName: String) async -> TrackSummaryModel? {
        do {
            return try await pitlapService.getTrackSummary(trackName: trackName)
        } catch {
            print("Error loading track summary \(error.localizedDescription)")
        }
        return nil
    }
}
