//
//  DriverStatsView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//

import PitlapKit
import SwiftUI

struct ConstructorStatsView: View {
    private let constructor: ConstructorStandingModel
    
    init(constructor: ConstructorStandingModel) {
        self.constructor = constructor
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                ThemeManager.shared.selectedTeamColor.opacity(0.2),
                                Color.clear,
                            ]),
                        startPoint: .leading,
                        endPoint: .center
                    )
                )
                .shadow(radius: 8)

            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Driver")
                            .styleAsLabelMinimum()

                        Text(String(constructor.constructorName.prefix(3).capitalized))
                            .styleAsDisplayMedium()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text(constructor.positionText)
                            .foregroundColor(ThemeManager.shared.selectedTeamColor)
                            .styleAsDisplayHero()
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Points")
                            .styleAsLabelMinimum()

                        Text("\(constructor.points)")
                            .styleAsDisplaySmall()
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("Wins")
                            .styleAsLabelMinimum()

                        Text("\(constructor.wins)")
                            .styleAsDisplaySmall()
                    }
                }.padding(.top, 4)
            }
            .padding(32)
        }
        .frame(width: 200, height: 200)
        .containerBackground(Color(.systemBackground), for: .widget)
    }
}
