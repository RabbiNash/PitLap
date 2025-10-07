//
//  DriverStandingTool 2.swift
//  PitLap
//
//  Created by Tinashe Makuti on 07/10/2025.
//


import FoundationModels
import SwiftUI
@preconcurrency import PitlapKit

@available(iOS 26.0, *)
struct ScheduleTool: Tool {
    let name = "findFullSchedule"
    let description = "Gets race schedule for a given season"

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
        try await Pitlap().getService().getSchedule(year: year.asInt32, forceRefresh: false)
    }
}
