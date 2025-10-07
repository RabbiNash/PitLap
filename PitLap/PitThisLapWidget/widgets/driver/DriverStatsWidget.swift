//
//  DriverStatsWidget.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//

import SwiftUI
import WidgetKit
import PitlapKit

struct DriverStatsWidgetProvider: AppIntentTimelineProvider {
    private let pitlapService: PitlapService
    
    init(pitlapService: PitlapService = Pitlap.shared.getService()) {
        self.pitlapService = pitlapService
    }

    func placeholder(in context: Context) -> DriverStatsWidgetEntry {
        DriverStatsWidgetEntry(date: Date(), model: mock)
    }

    func snapshot(for configuration: DriverStatsAppIntent, in context: Context) async -> DriverStatsWidgetEntry {
       do {
           let models = try await pitlapService.getDriverStandings(forceRefresh: true)
           let model = models.first
           return DriverStatsWidgetEntry(date: Date(), model: model ?? mock)
       } catch {
           return DriverStatsWidgetEntry(date: Date(), model: mock)
       }
    }
    
    func timeline(for configuration: DriverStatsAppIntent, in context: Context) async -> Timeline<DriverStatsWidgetEntry> {
        let models = (try? await pitlapService.getDriverStandings(forceRefresh: true)) ?? []
        let selected = models.first { $0.driverId == configuration.driver?.id } ?? models.first
        
        let entry = DriverStatsWidgetEntry(
            date: Date(),
            model: selected ?? mock
        )
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        if let nextMidnight = calendar.nextDate(after: Date(),
                                                matching: DateComponents(hour: 0, minute: 0, second: 0),
                                                matchingPolicy: .nextTime) {
            return Timeline(entries: [entry], policy: .after(nextMidnight))
        }
        
        return Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(86400)))
    }


    
    private let mock: DriverStandingModel = .init(position: 1, positionText: "1", points: 200, wins: 5, driverId: "", driverNumber: 4, givenName: "Lando", familyName: "Noris", constructorName: "McLaren")    
        
}

struct DriverStatsWidgetEntryView : View {
    @Environment(\.widgetFamily) var family

    var entry: DriverStatsWidgetProvider.Entry

    var body: some View {

        switch family {
        case .systemSmall:
            DriverStatsView(driver: entry.model)
        default:
            EmptyView()
        }
    }
}

struct DriverStatsWidget: Widget {
    let kind: String = "DriverStatsWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: DriverStatsWidgetProvider()) { entry in
            DriverStatsWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
    }
}

//struct DriverStatsWidget: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    DriverStatsWidget()
//}
