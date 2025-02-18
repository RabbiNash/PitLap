//
//  RaceResultRow.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import SwiftUI
import PersistenceManager
import Kingfisher

struct RaceResultRow: View {
    private let rowModel: RaceResultEntity
    
    init(rowModel: RaceResultEntity) {
        self.rowModel = rowModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(rowModel.position)")
                    .foregroundStyle(.white)
                    .frame(width: 30)
                    .font(.custom("Noto Sans",size: 16))
                
                KFImage(URL(string: rowModel.headshotURL))
                    .resizable()
                    .cacheOriginalImage(true)
                    .roundCorner(
                        radius: .widthFraction(0.2),
                        roundingCorners: [.all]
                    )
                    .serialize(as: .PNG)
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading) {
                    Text(rowModel.fullName)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    
                    Text(rowModel.broadcastName)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(rowModel.points) pts")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text("\(rowModel.status)")
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.all, 24)
    }
}
