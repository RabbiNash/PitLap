//
//  RaceWeekendHeaderView.swift
//  Pit Lap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PitlapKit

struct RaceWeekendHeaderView: View {
    @AppStorage("selectedTeam") private var selectedTeam: String = F1Team.ferrari.rawValue
    private let event: EventScheduleModel

    init(event: EventScheduleModel) {
        self.event = event
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
                (Text("Round ") + Text("\(event.round)"))
                    .font(.custom("Noto Sans",size: 20))
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)

                Text(event.officialEventName)
                    .font(.custom("Audiowide",size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                HStack {
                    VStack(alignment: .leading) {
                        Text(event.country)
                            .font(.custom("Noto Sans",size: 20))
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                        
                        Text(Date.getHumanisedDate(dateString: event.session1DateUTC ?? " ") ?? " ")
                            .font(.custom("Noto Sans",size: 20))
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    if let track = RaceTrack.fromEventName(event.eventName) {
                        Image(track.rawValue)
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                }
            }
            .padding()
        }
    }
}
