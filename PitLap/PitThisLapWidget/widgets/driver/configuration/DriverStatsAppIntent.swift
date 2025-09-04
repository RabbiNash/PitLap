//
//  ConfigurationAppIntent.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//


import WidgetKit
import AppIntents

struct DriverStatsAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Driver Configuration"
    static var description = IntentDescription("Pick a Formula 1 driver to track.")
    
    @Parameter(
        title: "Driver",
        description: "Choose your favorite F1 driver",
        query: DriverQuery()
    )
    var driver: DriverEntity
}
