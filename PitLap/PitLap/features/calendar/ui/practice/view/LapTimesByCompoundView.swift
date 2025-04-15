//
//  LapTimesByCompoundView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 14/02/2025.
//

import SwiftUI
import PitlapKit

struct LapTimesByCompoundView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    let groupedLapModel: GroupedLapModel
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .center, spacing: 10) {
                    ForEach(groupedLapModel.compoundLaps, id: \.compound) { compoundLaps in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(compoundLaps.compound)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("Lap")
                                    .frame(width: 50, alignment: .leading)
                                Text("Time")
                                    .frame(width: 100, alignment: .leading)
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            
                            ForEach(compoundLaps.laps.sorted(by: { $0.lapNumber < $1.lapNumber }), id: \.lapNumber) { lap in
                                HStack {
                                    Text("\(lap.lapNumber)")
                                        .foregroundColor(.white)
                                        .frame(width: 50, alignment: .leading)
                                    Text(lap.lapTime)
                                        .foregroundColor(.white)
                                        .frame(width: 100, alignment: .leading)
                                }
                            }
                        }
                        Divider()
                    }
                    
                    HStack {
                        Text("Best Lap:")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                        Text(groupedLapModel.bestLapTime)
                            .foregroundStyle(.white)
                    }
                }.padding()
            }
        }.background {
            if #available(iOS 18.0, *) {
                let startColor = isDarkMode ? Color.black : Color.white
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                        [0.0, 0.5], [0.8, 0.2], [1.0, 0.5],
                        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                    ], colors: [
                        startColor, startColor, ThemeManager.shared.selectedTeamColor, F1Team.kick.color, F1Team.alpine.color, F1Team.astonMartin.color,
                        ThemeManager.shared.selectedTeamColor, ThemeManager.shared.selectedTeamColor, ThemeManager.shared.selectedTeamColor,
                        F1Team.mercedes.color, F1Team.williams.color, F1Team.haas.color,
                        F1Team.rb.color, F1Team.ferrari.color, F1Team.redBull.color, F1Team.mclaren.color
                    ])
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
