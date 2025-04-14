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
                    self.loadSeasonCalendar(year: "2025", showPastEvents: false)
                }
            }
        }
    }

    func loadSeasonCalendar(year: String, showPastEvents: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let calendar = self.dataLogic.getSeasonCalendar(for: year)
            self.seasonCalendar = showPastEvents ? calendar.filter { !self.isNextEvent(race: $0) }.reversed() : calendar.filter { self.isNextEvent(race: $0) }
            
            self.nextSession = getNextEvent(from: self.seasonCalendar)
        }
    }

    
    private func getNextEvent(from races: [RaceWeekendEntity]) -> RaceWeekendEntity? {
        return races.first(where: { isNextEvent(race: $0) })
    }
    
    private func isNextEvent(race: RaceWeekendEntity) -> Bool {
        let currentDate = Date()
        if race.eventFormat == .conventional {
            return Date.getDateFromString(dateString: race.session5DateUTC) ?? Date() > currentDate
        } else {
            return Date.getDateFromString(dateString: race.session3DateUTC) ?? Date() > currentDate
        }
    }
}
