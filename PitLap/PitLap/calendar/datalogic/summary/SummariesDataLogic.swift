//
//  SummariesDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import Foundation

protocol SummariesDataLogicType {
    func getRaceSummary(round: Int, year: Int) async -> RaceSummaryModel?
    func getTrackSummary(trackName: String) async -> TrackSummaryModel?
}

final class SummariesDataLogic: SummariesDataLogicType {
    
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiServiceImpl.shared) {
        self.apiService = apiService
    }
    
    func getRaceSummary(round: Int, year: Int) async -> RaceSummaryModel? {
        do {
            return try await apiService.fetchRaceSummary(round: round, year: year)
        } catch {
            print("Error loading race summary \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func getTrackSummary(trackName: String) async -> TrackSummaryModel? {
        do {
            return try await apiService.fetchTrackSummary(trackName: trackName)
        } catch {
            print("Error loading trackSumamry calendar: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    
}
