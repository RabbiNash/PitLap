//
//  WidgetEntry.swift
//  PitLapWidgetExtension
//
//  Created by Tinashe Makuti on 22/04/2025.
//

import Foundation
import WidgetKit
import PitlapKit

struct ScheduleWidgetEntry: TimelineEntry {
    let date: Date
    let model: EventScheduleModel
    
    init(date: Date, model: EventScheduleModel) {
        self.date = date
        self.model = model
    }
}
