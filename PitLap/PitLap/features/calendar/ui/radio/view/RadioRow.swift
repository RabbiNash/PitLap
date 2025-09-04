//
//  QualiResultRow.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import SwiftUI
import Kingfisher
import PitlapKit

struct RadioRow: View {
    private let rowModel: TeamRadioModel
    private let raceResultModel: RaceResultModel
    
    init(rowModel: TeamRadioModel, raceResultModel: RaceResultModel) {
        self.rowModel = rowModel
        self.raceResultModel = raceResultModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(raceResultModel.position)")
                    .foregroundStyle(.white)
                    .frame(width: 30)
                    .font(.custom("Noto Sans",size: 16))
                
                KFImage(URL(string: raceResultModel.headshotURL))
                    .resizable()
                    .cacheOriginalImage(true)
                    .roundCorner(
                        radius: .widthFraction(0.2),
                        roundingCorners: [.all]
                    )
                    .serialize(as: .PNG)
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading) {
                    Text(raceResultModel.fullName)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    
                    Text(raceResultModel.teamName)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(Date.getHumanisedShortDateWithTime(apiDate: rowModel.date) ?? "")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.all, 24)
    }
    
}
