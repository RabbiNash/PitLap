//
//  SeasonCalendarDataLogic.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import SwiftData
import PitlapKit

protocol RaceCalendarDataLogicType {
    func getRaceCalendar(for year: Int, forceRefresh: Bool) async -> [EventScheduleModel]
    func isDataLoaded() async -> Bool
}

final class RaceCalendarDataLogic: RaceCalendarDataLogicType {
    private let pitlapService: PitlapService

    init(pitlapService: PitlapService = Pitlap.shared.getService()) {
        self.pitlapService = pitlapService
    }

    func getRaceCalendar(for year: Int, forceRefresh: Bool = false) async -> [EventScheduleModel] {
        let events = try? await pitlapService.getSchedule(year: year.asInt32, forceRefresh: forceRefresh)
        return events ?? []
    }

    func isDataLoaded() async -> Bool {
        let events = try? await pitlapService.getSchedule(year: 2025, forceRefresh: false)
        return events != nil
    }
}
