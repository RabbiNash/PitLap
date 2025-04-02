//
//  RaceWeekendListView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PersistenceManager

struct RaceWeekendListItemView: View {

    private let weekend: RaceWeekendEntity

    init(weekend: RaceWeekendEntity) {
        self.weekend = weekend
    }

    var body: some View {

        HStack(spacing: 16) {
                Text(Date.getDayOnly(dateString: weekend.session1DateUTC) ?? " ")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(width: 32)
                                          
                VStack(alignment: .leading) {
                    Text(weekend.officialEventName)
                        .lineLimit(3)

                    Text(weekend.country)
                        .font(.custom("Noto Sans", size: 16))
                        .fontWeight(.semibold)
                        .foregroundStyle(ThemeManager.shared.selectedTeamColor)

                    HStack {
                        ForEach(weekend.results.sorted { $0.position < $1.position }.prefix(3)) { result in
                            HStack(spacing: 0) {
                                Text("\(result.position) -")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    .frame(maxWidth: 24)
                                    .foregroundStyle(Color(hex: "#\(result.teamColor))"))

                                Text(result.driver)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "#\(result.teamColor))"))

                                Spacer()
                            }
                            .padding(.top, 4)
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                
                Spacer()
                
                if let track = RaceTrack.fromEventName(weekend.eventName) {
                    Image(track.rawValue)
                        .resizable()
                        .frame(width: 64, height: 64)
                }
            }
        .padding(.vertical, 12)
    }
}
