//
//  PitThisLapWidget.swift
//  PitThisLapWidget
//
//  Created by Tinashe MAKUTI on 14/01/2025.
//

import WidgetKit
import SwiftUI
import PitlapKit

struct ScheduleWidgetProvider: AppIntentTimelineProvider {
    
    private let pitlapService: PitlapService
    
    init(pitlapService: PitlapService = Pitlap.shared.getService()) {
        self.pitlapService = pitlapService
    }

    func placeholder(in context: Context) -> ScheduleWidgetEntry {
        ScheduleWidgetEntry(date: Date(), model: mock)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> ScheduleWidgetEntry {
       do {
           let models = try await pitlapService.getSchedule(year: 2025, forceRefresh: false)
           let model = getNextEvent(from: models)
           return ScheduleWidgetEntry(date: Date(), model: model ?? mock)
       } catch {
           return ScheduleWidgetEntry(date: Date(), model: mock)
       }
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<ScheduleWidgetEntry> {
        let models = (try? await pitlapService.getSchedule(year: 2025, forceRefresh: false)) ?? []
        let nextEvent = getNextEvent(from: models)
            
        let entry = ScheduleWidgetEntry(
            date: Date(),
            model: nextEvent ?? mock
        )
            
        let nextUpdateDate = Date.getDateFromString(dateString: nextEvent?.session5DateUTC ?? "") ?? Date().addingTimeInterval(3600)
        return Timeline(entries: [entry], policy: .after(nextUpdateDate))
    }
    
    private let mock: EventScheduleModel = .init(round: 1, country: "England", officialEventName: "", eventName: "", eventFormat: "", session1: "", session1DateUTC: "", session2: "", session2DateUTC: "", session3: "", session3DateUTC: "", session4: "", session4DateUTC: "", session5: "", session5DateUTC: "", year: "")
    
    private func getNextEvent(from events: [EventScheduleModel]) -> EventScheduleModel? {
        let now = Date()
        return events.first { event in
            guard let eventDate = eventCutoffDate(for: event) else { return false }
            return eventDate > now
        }
    }

    private func eventCutoffDate(for event: EventScheduleModel) -> Date? {
        let dateString: String?

        if event.eventFormat == "testing" {
            dateString = event.session3DateUTC
        } else {
            dateString = event.session5DateUTC
        }

        guard let baseDate = Date.getDateFromString(dateString: dateString ?? "") else {
            return nil
        }

        return Calendar.current.date(byAdding: .day, value: 1, to: baseDate)
    }
        
}

struct PitThisLapWidgetEntryView : View {
    @Environment(\.widgetFamily) var family

    var entry: ScheduleWidgetProvider.Entry

    var body: some View {

        switch family {
        case .systemMedium:
            MediumScheduleEventWidget(event: entry.model)
        case .systemLarge:
            LargeScheduleEventWidget(event: entry.model)
        case .accessoryRectangular:
            AccessoryScheduleEventView(model: entry.model)
        default:
            EmptyView()
        }
    }
}

struct ScheduleWidget: Widget {
    let kind: String = "PitThisLapWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: ScheduleWidgetProvider()) { entry in
            PitThisLapWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium, .systemLarge, .accessoryRectangular])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }

    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

/// Widget view for `accessoryInline `
struct InlineWidgetView: View {

    var body: some View {
        Text("🤷🏻‍♂️ View size not available 🤷🏻‍♀️")
    }
}

//    private func getNextEvent(from races: [RaceWeekendEntity]) -> RaceWeekendEntity? {
//        let currentDate = Date()
//        return races.first(where: { Date.getDateFromString(dateString: $0.session2DateUTC) ?? Date() > currentDate })
//    }
//}

/// Widget view for `accessoryCircular`
struct CircularWidgetView: View {

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AccessoryWidgetBackground()
                VStack {
                    Text("W: \(Int(geometry.size.width))")
                        .font(.headline)
                    Text("H: \(Int(geometry.size.height))")
                        .font(.headline)
                }
            }
            .containerBackground(for: .widget) { }
        }
    }
}

//#Preview(as: .systemSmall) {
//    PitThisLapWidget()
//} timeline: {
//    PitThisLapEntry(date: .now, configuration: .smiley)
//    PitThisLapEntry(date: .now, configuration: .starEyes)
//}
