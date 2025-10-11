//
//  RaceWeekendHeaderView.swift
//  Pit Lap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PitlapKit
import SwiftfulRouting

struct RaceWeekendHeaderView: View {
    @AppStorage("selectedTeam") private var selectedTeam: String = F1Team.ferrari.rawValue
    private let event: EventScheduleModel
    @State private var showLocationMap: Bool = false
    private let showMap: Bool

    init(event: EventScheduleModel, showMap: Bool = true) {
        self.event = event
        self.showMap = showMap
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [ThemeManager.shared.selectedTeamColor.opacity(0.3), Color.clear, Color.clear, ThemeManager.shared.selectedTeamColor.opacity(0.5)]), startPoint: .top, endPoint: .bottomTrailing)
                )
                .shadow(radius: 8)
            
            VStack(alignment: .leading) {
                HStack {
                    (Text(LocalizedStrings.round(Int(event.round))))
                        .font(.custom("Noto Sans",size: 16))
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    if showMap {
                        Image(systemName: "mappin.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .tint(.primary)
                            .onTapGesture {
                                showLocationMap = true
                            }
                    }
                    
                }
               

                Text(event.officialEventName)
                    .styleAsDisplaySmall()
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)

                HStack {
                    VStack(alignment: .leading) {
                        Text(event.country)
                            .font(.custom("Noto Sans",size: 16))
                            .fontWeight(.regular)
                            .foregroundStyle(.primary)
                        
                        Text(Date.getHumanisedDate(dateString: event.session1DateUTC ?? " ") ?? " ")
                            .font(.custom("Noto Sans",size: 16))
                            .fontWeight(.regular)
                            .foregroundStyle(.primary)
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
        }.fullScreenCover(isPresented: $showLocationMap) {
            TrackMapView(eventScheduleModel: event)
        }
    }
}
