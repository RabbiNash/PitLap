//
//  DriverStatsWidget.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/08/2025.
//

import SwiftUI
import WidgetKit
import PitlapKit

struct ConstructorStatsWidgetProvider: AppIntentTimelineProvider {
    private let pitlapService: PitlapService
    
    init(pitlapService: PitlapService = Pitlap.shared.getService()) {
        self.pitlapService = pitlapService
    }

    func placeholder(in context: Context) -> ConstructorStatsWidgetEntry {
        ConstructorStatsWidgetEntry(date: Date(), model: mock)
    }

    func snapshot(for configuration: ConstructorStatsAppIntent, in context: Context) async -> ConstructorStatsWidgetEntry {
       do {
           let models = try await pitlapService.getConstructorStandings(forceRefresh: true)
           let model = models.first
           return ConstructorStatsWidgetEntry(date: Date(), model: model ?? mock)
       } catch {
           return ConstructorStatsWidgetEntry(date: Date(), model: mock)
       }
    }
    
    func timeline(for configuration: ConstructorStatsAppIntent, in context: Context) async -> Timeline<ConstructorStatsWidgetEntry> {
        let models = (try? await pitlapService.getConstructorStandings(forceRefresh: true)) ?? []
        let selected = models.first { $0.constructorId == configuration.constructor?.id } ?? models.first
        
        let entry = ConstructorStatsWidgetEntry(
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


    
    private let mock: ConstructorStandingModel = .init(position: 1, positionText: "1", points: 1, wins: 5, constructorId: "mcl", constructorName: "McLaren")
        
}

struct ConstructorStatsWidgetEntryView : View {
    @Environment(\.widgetFamily) var family

    var entry: ConstructorStatsWidgetProvider.Entry

    var body: some View {

        switch family {
        case .systemSmall:
            ConstructorStatsView(constructor: entry.model)
        default:
            EmptyView()
        }
    }
}

struct ConstructorStatsWidget: Widget {
    let kind: String = "ConstructorStatsWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: ConstructorStatsWidgetProvider()) { entry in
            ConstructorStatsWidgetEntryView(entry: entry)
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
