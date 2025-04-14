//
//  RaceWeekendHeaderView.swift
//  Pit Lap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PersistenceManager

struct RaceWeekendHeaderView: View {
    private let weekend: RaceWeekendEntity

    @StateObject private var viewModel: RaceWeekendHeaderViewModel

    @AppStorage("selectedTeam") private var selectedTeam: String = F1Team.ferrari.rawValue

    init(
        weekend: RaceWeekendEntity,
        viewModel: RaceWeekendHeaderViewModel = RaceWeekendHeaderViewModel()
    ) {
        self.weekend = weekend
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            if #available(iOS 18.0, *) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        MeshGradient(
                            width: 3,
                            height: 3,
                            points: [
                                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                                [0.0, 0.5], [0.8, 0.2], [1.0, 0.5],
                                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                            ], colors: [
                                ThemeManager.shared.selectedTeamColor, F1Team.haas.color, ThemeManager.shared.selectedTeamColor, ThemeManager.shared.selectedTeamColor,ThemeManager.shared.selectedTeamColor, F1Team.haas.color,
                                ThemeManager.shared.selectedTeamColor, F1Team.haas.color, ThemeManager.shared.selectedTeamColor,
                                F1Team.mercedes.color, F1Team.haas.color, F1Team.haas.color,
                                ThemeManager.shared.selectedTeamColor, F1Team.ferrari.color, ThemeManager.shared.selectedTeamColor, ThemeManager.shared.selectedTeamColor
                            ])
                    )
                    .shadow(radius: 8)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(ThemeManager.shared.selectedTeamColor.gradient)
                    .shadow(radius: 8)
                
            }

            VStack(alignment: .leading) {
                (Text("Round ") + Text("\(weekend.round)"))
                    .font(.custom("Noto Sans",size: 20))
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)

                Text(weekend.officialEventName)
                    .font(.custom("Audiowide",size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                HStack {
                    VStack(alignment: .leading) {
                        Text(weekend.country)
                            .font(.custom("Noto Sans",size: 20))
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                        
                        Text(Date.getHumanisedDate(dateString: weekend.session1DateUTC) ?? " ")
                            .font(.custom("Noto Sans",size: 20))
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    if let track = RaceTrack.fromEventName(weekend.eventName) {
                        Image(track.rawValue)
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.startCountdown(targetDate: Date.getDateFromString(dateString: weekend.session5DateUTC))
        }
    }

    @ViewBuilder
    private var countdown: some View {
        HStack {
            VStack(alignment: .center) {
                Text(viewModel.days)
                    .font(.title)
                    .foregroundStyle(.red)
                Text("Days")
                    .font(.caption)
            }

            Spacer()

            VStack(alignment: .center) {
                Text(viewModel.hours)
                    .font(.title)
                    .foregroundStyle(ThemeManager.shared.selectedTeamColor)
                Text("Hours")
                    .font(.caption)
            }

            Spacer()

            VStack(alignment: .center) {
                Text(viewModel.minutes)
                    .font(.title)
                    .foregroundStyle(ThemeManager.shared.selectedTeamColor)
                Text("Minutes")
                    .font(.caption)
            }

            Spacer()

            VStack(alignment: .center) {
                Text(viewModel.seconds)
                    .font(.title)
                    .foregroundStyle(.green)
                Text("Seconds")
                    .font(.caption)
            }
        }
    }
}
