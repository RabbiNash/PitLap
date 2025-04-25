//
//  LargeScheduleEventWidget.swift
//  PitLapWidgetExtension
//
//  Created by Tinashe Makuti on 22/04/2025.
//

import SwiftUI
import PitlapKit

struct MediumScheduleEventWidget: View {
    private let event: EventScheduleModel

    init(event: EventScheduleModel) {
        self.event = event
    }

    var body: some View {
        ScheduleHeaderView(event: event)
            .containerBackground(Color(.systemBackground), for: .widget)
    }
}
