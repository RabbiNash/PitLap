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
    private let weatherDataLogic: WeatherDataLogicType
    
    @Published private(set) var trackSummary: TrackSummaryModel?
    @Published private(set) var raceSummary: RaceSummaryModel?
    @Published private(set) var weather: WeatherModel?
    @Published private(set) var isLoading = false
    
    init(
        datalogic: RaceSummaryDataLogicType = RaceSummaryDataLogic(),
        weatherDataLogic: WeatherDataLogicType = WeatherDataLogic()
    ) {
        self.datalogic = datalogic
        self.weatherDataLogic = weatherDataLogic
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
        async let weatherTask = weatherDataLogic.getWeather(year: year, round: round)
        let (raceResult, trackResult, weather) = await (raceSummaryTask,trackSummaryTask, weatherTask)
        self.raceSummary = raceResult
        self.trackSummary = trackResult
        self.weather = weather
    }
}
