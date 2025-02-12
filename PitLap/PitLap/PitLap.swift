//
//  Box_BoxApp.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import SwiftData
import PersistenceManager

@main
struct PitLapApp: App {

    @AppStorage("selectedTeam") private var selectedTeam: String = F1Team.astonMartin.rawValue

    var body: some Scene {
        WindowGroup {
            ViewCoordinator()
                .environment(\.font, Font.custom("Noto Sans", size: 16))
                .preferredColorScheme(.light)
                .applyAccentColor()
        }.modelContainer(for: [RaceWeekendEntity.self, RaceResultEntity.self])
    }

    init(){
        for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }
}
