//
//  PitThisLapWidgetBundle.swift
//  PitThisLapWidget
//
//  Created by Tinashe MAKUTI on 14/01/2025.
//

import WidgetKit
import SwiftUI

@main
struct PitThisLapWidgetBundle: WidgetBundle {
    var body: some Widget {
        ScheduleWidget()
        DriverStatsWidget()
        ConstructorStatsWidget()
    }
}
