//
//  ScheduleHeaderView.swift
//  PitLapWidgetExtension
//
//  Created by Tinashe Makuti on 22/04/2025.
//

import SwiftUI
import PitlapKit

struct ScheduleHeaderView: View {
    private let event: EventScheduleModel
    
    init(event: EventScheduleModel) {
        self.event = event
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Round \(event.round)")
                .customFont(name: "Noto Sans", size: 12, weight: .semibold)

            Text(event.officialEventName)
                .customFont(name: "Audiowide", size: 16, weight: .bold)
                .lineLimit(2)

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.country)
                        .customFont(name: "Noto Sans", size: 12, weight: .semibold)

                    Text("\(formattedSessionDate(event.session5DateUTC))")
                        .customFont(name: "Noto Sans", size: 12, weight: .semibold)
                }

                Spacer()

                if let track = RaceTrack.fromEventName(event.eventName) {
                    Image(track.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                }
            }
        }
    }
    
    private func formattedSessionDate(_ dateString: String?) -> String {
        guard let dateString = dateString,
              let date = Date.getHumanisedDate(dateString: dateString) else {
            return ""
        }
        return date
    }
}
