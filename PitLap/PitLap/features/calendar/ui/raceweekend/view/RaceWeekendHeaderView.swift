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
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.gray.opacity(0.6), Color.clear]), startPoint: .top, endPoint: .bottom)
                )
            
            VStack(alignment: .leading) {
                (Text("Round ") + Text("\(event.round)"))
                    .font(.custom("Noto Sans",size: 20))
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)

                Text(event.officialEventName)
                    .styleAsDisplayMedium()
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
