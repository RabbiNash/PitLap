//
//  EventWidget.swift
//  PitLapWidgetExtension
//
//  Created by Tinashe Makuti on 22/04/2025.
//

import SwiftUI
import PitlapKit
import WidgetKit

struct LargeScheduleEventWidget: View {
    private let event: EventScheduleModel

    init(event: EventScheduleModel) {
        self.event = event
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScheduleHeaderView(event: event)

            Divider()

            ForEach(SessionType.allCases, id: \.self) { sessionType in
                if let sessionTime = event.sessionTime(for: sessionType) {
                    if event.sessionName(for: sessionType) != "None" {
                        EventSession(sessionName: event.sessionName(for: sessionType), sessionTime: sessionTime)
                    }
                }
            }
        }
        .containerBackground(Color(.systemBackground), for: .widget)
    }

    private func formattedSessionDate(_ dateString: String?) -> String {
        guard let dateString = dateString,
              let date = Date.getHumanisedDate(dateString: dateString) else {
            return ""
        }
        return date
    }
}
