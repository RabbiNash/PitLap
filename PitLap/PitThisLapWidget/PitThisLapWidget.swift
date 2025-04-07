//
//  PitThisLapWidget.swift
//  PitThisLapWidget
//
//  Created by Tinashe MAKUTI on 14/01/2025.
//

import WidgetKit
import SwiftUI
import SwiftData
import PersistenceManager

struct Provider: AppIntentTimelineProvider {

    func placeholder(in context: Context) -> PitThisLapEntry {
        PitThisLapEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> PitThisLapEntry {
        PitThisLapEntry(date: Date(), configuration: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<PitThisLapEntry> {
        var entries: [PitThisLapEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = PitThisLapEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let entry = PitThisLapEntry(date: currentDate, configuration: configuration)

        entries.append(entry)

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct PitThisLapEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct PitThisLapWidgetEntryView : View {
    @Environment(\.widgetFamily) var family

    var entry: Provider.Entry

    var body: some View {

        switch family {
        case .accessoryRectangular:
            RectangularWidgetView(entry: entry)
        default:
            EmptyView()
        }
    }
}

struct PitThisLapWidget: Widget {
    let kind: String = "PitThisLapWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            PitThisLapWidgetEntryView(entry: entry)
                .modelContainer(for: [RaceWeekendEntity.self])      .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,

            // Add Support to Lock Screen widgets
            .accessoryCircular,
            .accessoryRectangular,
            .accessoryInline,
        ])

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

/// Widget view for `accessoryRectangular`
struct RectangularWidgetView: View {

    var entry: Provider.Entry

    @Query var model: [RaceWeekendEntity]

    init(entry: Provider.Entry) {
        self.entry = entry
    }

    var body: some View {
        HStack {
            Divider()
                .frame(maxHeight: .infinity)
                .overlay(Rectangle().frame(width: 1).foregroundColor(.primary))

            VStack(alignment: .leading) {
                let race = getNextEvent(from: model)

                Text(race?.eventName ?? " ")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(race?.eventFormat.rawValue.capitalized ?? " ")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(Date.getCustomFormattedDate(apiDate: race?.session1DateUTC ?? "") ?? " ")
                    .font(.caption2)
                    .fontWeight(.light)

                Spacer()

                HStack {
                    Text(race?.country ?? " ")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    Spacer()

                }
            }
            .padding(8)

            Spacer()

            Divider()
                .frame(maxHeight: .infinity)
                .overlay(Rectangle().frame(width: 1).foregroundColor(.primary))
        }
    }

    private func getNextEvent(from races: [RaceWeekendEntity]) -> RaceWeekendEntity? {
        let currentDate = Date()
        return races.first(where: { Date.getDateFromString(dateString: $0.session2DateUTC) ?? Date() > currentDate })
    }
}

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

#Preview(as: .systemSmall) {
    PitThisLapWidget()
} timeline: {
    PitThisLapEntry(date: .now, configuration: .smiley)
    PitThisLapEntry(date: .now, configuration: .starEyes)
}
