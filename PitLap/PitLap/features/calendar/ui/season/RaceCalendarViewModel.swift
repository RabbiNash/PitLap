//
//  SeasonCalendarViewModel.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import PitlapKit

final class RaceCalendarViewModel: ObservableObject {
    private let dataLogic: RaceCalendarDataLogicType

    @Published private(set) var nextSession: EventScheduleModel?
    @Published private(set) var seasonCalendar: [EventScheduleModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var currentYear: Int = 2025

    init(dataLogic: RaceCalendarDataLogicType = RaceCalendarDataLogic()) {
        self.dataLogic = dataLogic
    }

    func viewDidAppear(showPastEvents: Bool = false) {
        currentYear = Calendar.current.component(.year, from: Date())
        loadSeasonCalendar(year: currentYear, showPastEvents: showPastEvents)
    }

    func loadSeasonCalendar(year: Int, showPastEvents: Bool = false) {
        isLoading = true
        Task { @MainActor in
            let calendar = await dataLogic.getRaceCalendar(for: year)
            let filtered = filterEvents(calendar, showPastEvents: showPastEvents)
            seasonCalendar = filtered
            nextSession = getNextEvent(from: filtered)
            isLoading = false
        }
    }

    private func filterEvents(_ events: [EventScheduleModel], showPastEvents: Bool) -> [EventScheduleModel] {
        let now = Date()
        let filtered = events.filter { event in
            guard let eventDate = eventDate(for: event) else { return false }
            return showPastEvents ? eventDate < now : eventDate > now
        }
        return showPastEvents ? filtered.reversed() : filtered
    }

    private func getNextEvent(from events: [EventScheduleModel]) -> EventScheduleModel? {
        let now = Date()
        return events.first { event in
            guard let eventDate = eventDate(for: event) else { return false }
            return eventDate > now
        }
    }

    private func eventDate(for event: EventScheduleModel) -> Date? {
        if event.eventFormat == "convectional" {
            return Date.getDateFromString(dateString: event.session5DateUTC ?? "")
        } else {
            return Date.getDateFromString(dateString: event.session3DateUTC ?? "")
        }
    }
}
