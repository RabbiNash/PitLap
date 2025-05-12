//
//  RectangularWidgetView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 25/04/2025.
//

import SwiftUI
import PitlapKit

struct AccessoryScheduleEventView: View {
    
    var model: EventScheduleModel
    
    init(model: EventScheduleModel) {
        self.model = model
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if let track = RaceTrack.fromEventName(model.eventName) {
                Image(track.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .clipped()
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text(model.eventName.replacing("Grand Prix", with: "GP"))
                    .styleAsDisplaySmallest()
                    .fontWeight(.bold)
                    .padding(.vertical, 0)
                
                Text(formattedSessionDate(model.session5DateUTC))
                    .styleAsLabelSmall()
                    .padding(.bottom, 4)
                
                DeterminateProgressView(progress: CGFloat(model.round) / 24)
            }
        }
        .containerBackground(Color(.black.withAlphaComponent(0.9)), for: .widget)
    }
    
    private func formattedSessionDate(_ dateString: String?) -> String {
        guard let dateString = dateString,
              let date = Date.getHumanisedAbbreviatedDate(apiDate: dateString) else {
            return ""
        }
        return date
    }
}
