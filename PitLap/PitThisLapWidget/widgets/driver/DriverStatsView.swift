//
//  DriverStatsView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//

import PitlapKit
import SwiftUI

struct DriverStatsView: View {
    private let driver: DriverStandingModel
    
    init(driver: DriverStandingModel) {
        self.driver = driver
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

                        Text(String(driver.familyName.prefix(3).capitalized))
                            .styleAsDisplayMedium()
                        
                        Text(driver.constructorName)
                            .styleAsDisplaySmallest()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text(driver.positionText)
                            .foregroundColor(ThemeManager.shared.selectedTeamColor)
                            .styleAsDisplayHero()
                    }
                }
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Points")
                            .styleAsLabelMinimum()

                        Text("\(driver.points)")
                            .styleAsDisplaySmall()
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("Wins")
                            .styleAsLabelMinimum()

                        Text("\(driver.wins)")
                            .styleAsDisplaySmall()
                    }
                }
                .padding(.top, 2)
            }
            .padding(32)
        }
        .frame(width: 200, height: 200)
        .containerBackground(Color(.systemBackground), for: .widget)
    }
}
