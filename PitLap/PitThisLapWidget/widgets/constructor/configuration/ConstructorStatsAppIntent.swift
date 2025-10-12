//
//  ConfigurationAppIntent.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//


import WidgetKit
import AppIntents

struct ConstructorStatsAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Driver Configuration"
    static var description = IntentDescription("Pick a Formula 1 team to track")
    
    @Parameter(
        title: "Constructor",
        description: "Choose your favorite Constructor",
        query: ConstructorQuery()
    )
    var constructor: ConstructorEntity?
}
