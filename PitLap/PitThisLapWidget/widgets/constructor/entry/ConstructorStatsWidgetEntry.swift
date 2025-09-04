//
//  ScheduleWidgetEntry.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//
import SwiftUI
import PitlapKit
import WidgetKit

struct ConstructorStatsWidgetEntry: TimelineEntry {
    let date: Date
    let model: ConstructorStandingModel
    
    init(date: Date, model: ConstructorStandingModel) {
        self.date = date
        self.model = model
    }
}
