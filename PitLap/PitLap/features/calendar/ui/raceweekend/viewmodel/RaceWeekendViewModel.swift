//
//  SummariesViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import Foundation
import PitlapKit

final class RaceWeekendViewModel: ObservableObject {
    private let datalogic: RaceSummaryDataLogicType
    
    @Published private(set) var trackSummary: TrackSummaryModel?
    @Published private(set) var raceSummary: RaceSummaryModel?
    @Published private(set) var isLoading = false
    
    init(datalogic: RaceSummaryDataLogicType = RaceSummaryDataLogic()) {
        self.datalogic = datalogic
    }
    
    func viewDidAppear(round: Int, year: Int, trackName: String) {
        guard !isLoading else { return }
        
        Task {
            await fetchSummaries(round: round, year: year, trackName: trackName)
        }
    }
    
    @MainActor
    private func fetchSummaries(round: Int, year: Int, trackName: String) async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        async let raceSummaryTask = datalogic.fetchRaceSummary(round: round, year: year)
        async let trackSummaryTask = datalogic.fetchTrackFacts(trackName: trackName)
        let (raceResult, trackResult) = await (raceSummaryTask,trackSummaryTask)
        self.raceSummary = raceResult
        self.trackSummary = trackResult
    }
}
