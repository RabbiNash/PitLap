//
//  ScheduleTool 2.swift
//  PitLap
//
//  Created by Tinashe Makuti on 08/10/2025.
//


import FoundationModels
import SwiftUI
@preconcurrency import PitlapKit

@available(iOS 26.0, *)
struct RemainingRacesScheduleTool: Tool {
    let name = "findRemainingRacesSchedule"
    let description = "Gets the remaining race schedule for a given season"

    @Generable
    struct Arguments {
        @Guide(description: "The current year")
        let year: Int
    }
    
    func call(arguments: Arguments) async throws -> [String] {
        let schedule: [EventScheduleModel] = try await getCurrentSchedule(year: arguments.year)
        let formattedSchedule = schedule.map {
            "Round: \($0.round) Year: \($0.year) OfficialEventName: \($0.officialEventName), Race : \($0.session5DateUTC ?? "")"
        }
        return formattedSchedule
    }
    
    func getCurrentSchedule(year: Int) async throws -> [EventScheduleModel] {
        let events = try await Pitlap().getService().getSchedule(year: year.asInt32, forceRefresh: false)
        return filterEvents(events, showPastEvents: false)
    }
    
    private func filterEvents(_ events: [EventScheduleModel], showPastEvents: Bool) -> [EventScheduleModel] {
        let now = Date()
        let filtered = events.filter { event in
            guard let eventDate = eventCutoffDate(for: event) else { return false }
            return showPastEvents ? eventDate < now : eventDate > now
        }
        return showPastEvents ? filtered.reversed() : filtered
    }

    private func getNextEvent(from events: [EventScheduleModel]) -> EventScheduleModel? {
        let now = Date()
        return events.first { event in
            guard let eventDate = eventCutoffDate(for: event) else { return false }
            return eventDate > now
        }
    }

    private func eventCutoffDate(for event: EventScheduleModel) -> Date? {
        let dateString: String?

        if event.eventFormat == "testing" {
            dateString = event.session3DateUTC
        } else {
            dateString = event.session5DateUTC
        }

        guard let baseDate = Date.getDateFromString(dateString: dateString ?? "") else {
            return nil
        }

        return Calendar.current.date(byAdding: .day, value: 1, to: baseDate)
    }
}
