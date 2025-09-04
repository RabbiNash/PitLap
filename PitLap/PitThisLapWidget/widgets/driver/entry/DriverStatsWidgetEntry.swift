//
//  ScheduleWidgetEntry.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//
import SwiftUI
import PitlapKit
import WidgetKit

struct DriverStatsWidgetEntry: TimelineEntry {
    let date: Date
    let model: DriverStandingModel
    
    init(date: Date, model: DriverStandingModel) {
        self.date = date
        self.model = model
    }
}
