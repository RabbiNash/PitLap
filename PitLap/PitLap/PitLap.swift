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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ViewCoordinator()
                .environment(\.font, Font.custom("Noto Sans", size: 16))
                .modifier(ColorSchemeModifier())
                .applyAccentColor()
        }.modelContainer(for: [RaceWeekendEntity.self, RaceResultEntity.self])
    }
}
