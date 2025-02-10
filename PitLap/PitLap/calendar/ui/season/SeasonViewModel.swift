//
//  SeasonCalendarViewModel.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import PersistenceManager

@MainActor
final class SeasonViewModel: ObservableObject {
    private let dataLogic: SeasonDataLogicType

    @Published var nextSession: RaceWeekendEntity? = nil
    
    @Published var seasonCalendar: [RaceWeekendEntity] = []

    init(dataLogic: SeasonDataLogicType) {
        self.dataLogic = dataLogic
    }

    func viewDidAppear() {
        Task {
            await dataLogic.loadSeasons { [weak self] isLoaded in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.loadSeasonCalendar(year: "2025")
                }
            }
        }
    }

    func loadSeasonCalendar(year: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.seasonCalendar = self.dataLogic.getSeasonCalendar(for: year)
            if let session = getNextEvent(from: seasonCalendar) {
                self.nextSession = session
            }
        }
    }
    
    private func getNextEvent(from races: [RaceWeekendEntity]) -> RaceWeekendEntity? {
        let currentDate = Date()
        return races.first(where: { Date.getDateFromString(dateString: $0.session1DateUTC) ?? Date() > currentDate })
    }
}
