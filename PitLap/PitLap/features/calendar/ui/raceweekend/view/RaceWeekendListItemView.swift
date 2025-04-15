//
//  RaceWeekendListView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PitlapKit

struct RaceWeekendListItemView: View {

    private let event: EventScheduleModel
    
    init(event: EventScheduleModel) {
        self.event = event
    }

    var body: some View {

        HStack(spacing: 16) {
            Text(Date.getDayOnly(dateString: event.session1DateUTC ?? "") ?? " ")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: 32)
                                          
                VStack(alignment: .leading) {
                    Text(event.officialEventName)
                        .lineLimit(3)

                    Text(event.country)
                        .font(.custom("Noto Sans", size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(ThemeManager.shared.selectedTeamColor)
                }
                
                Spacer()
                
                if let track = RaceTrack.fromEventName(event.eventName) {
                    Image(track.rawValue)
                        .resizable()
                        .frame(width: 64, height: 64)
                }
            }
        .padding(.vertical, 12)
    }
}
