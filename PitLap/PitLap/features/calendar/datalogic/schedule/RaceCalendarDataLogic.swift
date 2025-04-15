//
//  SeasonCalendarDataLogic.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import SwiftData
import PersistenceManager
import PitlapKit

protocol RaceCalendarDataLogicType {
    func getRaceCalendar(for year: Int) async -> [EventScheduleModel]
    func isDataLoaded() async -> Bool
}

final class RaceCalendarDataLogic: RaceCalendarDataLogicType {
    private let pitlapService: PitlapService

    init(pitlapService: PitlapService = Pitlap.shared.getService()) {
        self.pitlapService = pitlapService
    }

    func getRaceCalendar(for year: Int) async -> [EventScheduleModel] {
        let events = try? await pitlapService.getSchedule(year: year.asInt32)
        return events ?? []
    }

    func isDataLoaded() async -> Bool {
        let events = try? await pitlapService.getSchedule(year: 2025)
        return events != nil
    }
}
