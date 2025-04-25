//
//  SessionItemView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/04/2025.
//
import SwiftUI

struct EventSession: View {
    private let sessionName: String
    private let sessionTime: String

    init(sessionName: String, sessionTime: String) {
        self.sessionName = sessionName
        self.sessionTime = sessionTime
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(sessionName)
                    .customFont(name: "Noto Sans", size: 12, weight: .semibold)
                    .frame(maxWidth: 120, alignment: .leading)

                Spacer()
                
                Text(Date.getHumanisedDate(dateString: sessionTime) ?? " ")
                    .customFont(name: "Noto Sans", size: 12, weight: .semibold)
                    .lineLimit(2)
            }
            .frame(alignment: .leading)
            
            Divider()
        }
    }
    
    private func isPastEvent(sessionTime: String) -> Bool {
        let currentDate = Date()
        return Date.getDateFromString(dateString: sessionTime) ?? Date() < currentDate
    }
}
