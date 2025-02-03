//
//  SeasonCalendarViewModel.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import PersistenceManager

final class SeasonViewModel: ObservableObject {
    private let dataLogic: SeasonDataLogicType

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
        }
    }
}
