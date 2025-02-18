//
//  StandingRow.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import Foundation
import SwiftUI

struct StandingRow: View {
    let rowModel: StandingRowModel
    
    init(rowModel: StandingRowModel) {
        self.rowModel = rowModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(rowModel.position)
                    .frame(width: 30)
                    .font(.custom("Noto Sans",size: 16))


                VStack(alignment: .leading) {
                    if let fullName = rowModel.fullName {
                        Text(fullName)
                            .fontWeight(.bold)
                        
                        Text(rowModel.constructorName)
                            .foregroundColor(.secondary)
                    } else {
                        Text(rowModel.constructorName)
                            .fontWeight(.bold)
                    }
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("\(rowModel.points) pts")
                        .fontWeight(.bold)
                    Text("\(rowModel.wins) wins")
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
        }
        .padding(.vertical, 8)
    }
}
