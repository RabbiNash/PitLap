//
//  QualiResultRow.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import SwiftUI
import PersistenceManager
import Kingfisher

struct QualiResultRow: View {
    private let rowModel: QualiResultModel
    
    init(rowModel: QualiResultModel) {
        self.rowModel = rowModel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            driverInfoSection
            Divider()
            qualifyingTimesSection
            Divider()
        }.padding(.vertical, 8)
    }
    
    private var driverInfoSection: some View {
        HStack {
            Text("\(rowModel.position)")
                .frame(width: 30)
                .font(.custom("Noto Sans", size: 16))
            
            KFImage(URL(string: rowModel.headshotUrl))
                .resizable()
                .cacheMemoryOnly()
                .roundCorner(radius: .widthFraction(0.2), roundingCorners: .all)
                .serialize(as: .PNG)
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading) {
                Text(rowModel.fullName)
                    .fontWeight(.bold)
                Text(rowModel.teamName)
            }
            
            Spacer()
        }
    }
    
    private var qualifyingTimesSection: some View {
        HStack {
            qualifyingTimeView(session: "Q1", time: rowModel.q1)
            qualifyingTimeView(session: "Q2", time: rowModel.q2)
            qualifyingTimeView(session: "Q3", time: rowModel.q3)
        }
    }
    
    private func qualifyingTimeView(session: String, time: String?) -> some View {
        HStack {
            Image(systemName: "timer")
                .resizable()
                .frame(width: 12, height: 12)
            
            Text("\(session)- ")
                .font(.custom("Noto Sans", size: 12))
                .fontWeight(.semibold)
            + Text(time ?? " ")
                .font(.custom("Noto Sans", size: 12))
                .fontWeight(.light)
        }
        .frame(maxWidth: .infinity)
    }
}
