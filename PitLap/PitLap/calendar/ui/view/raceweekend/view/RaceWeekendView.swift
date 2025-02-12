//
//  RaceWeekendView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PersistenceManager

struct RaceWeekendView: View {

    private let weekend: RaceWeekendEntity
    @Namespace var namespace

    init(weekend: RaceWeekendEntity) {
        self.weekend = weekend
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {

                    RaceWeekendHeaderView(weekend: weekend)

                    Text(weekend.eventName)
                        .font(.custom("Audiowide",size: 24))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 8)
                        .foregroundColor(.primary)
                        .background(
                            ThemeManager.shared.selectedTeamColor.frame(height: 6)
                                .offset(y: 24)
                        )
                    

                    sessionTimes

                }.padding(24)
            }
        }
    }
    
    private func getNextEvent(from races: [RaceWeekendEntity]) -> RaceWeekendEntity? {
        let currentDate = Date()
        return races.first(where: { Date.getDateFromString(dateString: $0.session1DateUTC) ?? Date() > currentDate })
    }

    @ViewBuilder
    private var sessionTimes: some View {
        SessionItemView(sessionName: weekend.session1.rawValue, sessionTime: weekend.session1DateUTC)
        SessionItemView(sessionName: weekend.session2.rawValue, sessionTime: weekend.session2DateUTC)
        SessionItemView(sessionName: weekend.session3.rawValue, sessionTime: weekend.session3DateUTC)
        SessionItemView(sessionName: weekend.session4.rawValue, sessionTime: weekend.session4DateUTC)
        SessionItemView(sessionName: weekend.session5.rawValue, sessionTime: weekend.session5DateUTC)
    }
}
