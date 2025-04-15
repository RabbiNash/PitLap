//
//  PracticeResultRow.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import SwiftUI

import SwiftUI
import Kingfisher
import PitlapKit

struct PracticeResultRow: View {
    private let rowModel: GroupedLapModel
    
    init(rowModel: GroupedLapModel) {
        self.rowModel = rowModel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            driverInfoSection
            Divider()
                .overlay(Color.white.opacity(0.5))
            timesSection
            Divider()
                .overlay(Color.white.opacity(0.5))

        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
    
    private var driverInfoSection: some View {
        HStack {
            KFImage(URL(string: rowModel.headshotUrl))
                .resizable()
                .cacheOriginalImage(true)
                .roundCorner(radius: .widthFraction(0.2), roundingCorners: .all)
                .serialize(as: .PNG)
                .frame(width: 48, height: 48)
            
                Text(rowModel.fullName)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            
            Spacer()
        }
    }
    
    private var timesSection: some View {
        HStack {
            practiceTimeView(time: rowModel.bestLapTime)
        }
    }
    
    private func practiceTimeView(time: String?) -> some View {
        HStack {
            Image(systemName: "timer")
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 12, height: 12)
            
            Text(time ?? " ")
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .font(.custom("Noto Sans", size: 12))
                
        }
        .frame(maxWidth: .infinity)
    }
}
