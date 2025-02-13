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
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
    private var driverInfoSection: some View {
        HStack {
            Text("\(rowModel.position)")
                .foregroundStyle(.white)
                .frame(width: 30)
                .font(.custom("Noto Sans", size: 16))
            
            KFImage(URL(string: rowModel.headshotUrl))
                .resizable()
                .cacheOriginalImage(true)
                .roundCorner(radius: .widthFraction(0.2), roundingCorners: .all)
                .serialize(as: .PNG)
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading) {
                Text(rowModel.fullName)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                Text(rowModel.teamName)
                    .foregroundStyle(.white)
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
                .foregroundStyle(.white)
                .frame(width: 12, height: 12)
            
            (Text("\(session)- ")
                .fontWeight(.semibold)
            + Text(time ?? " ")
                .fontWeight(.light))
                .foregroundStyle(.white)
                .font(.custom("Noto Sans", size: 12))
                
        }
        .frame(maxWidth: .infinity)
    }
}
