//
//  DateUtils.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import SwiftUI

extension Date {
    static func getHumanisedDate(dateString: String) -> String? {
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: String(dateString))

        return date?.formatted(date: .long, time: .shortened)
    }

    static func getDayOnly(dateString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: dateString) else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd\nMMM"

        return dateFormatter.string(from: date)
    }

    static func getDayAndTimeWithNewLine(dateString: String) -> String? {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: dateString) else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"

        return dateFormatter.string(from: date)
    }

    static func getDateFromString(dateString: String) -> Date? {
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: String(dateString))

        return date
    }

    static func getHumanisedDateWithTime(apiDate: String) -> String? {
        let trimmedDate = apiDate.prefix(18) + "Z"
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: String(trimmedDate))

        return date?.formatted(date: .long, time: .standard)
    }

    static func getHumanisedShortDateWithTime(date: Date) -> String {
        return date.formatted(date: .abbreviated, time: .shortened)
    }

    static func getHumanisedShortDateWithTime(apiDate: String) -> String? {
        let trimmedDate = apiDate.prefix(18) + "Z"
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: String(trimmedDate))

        return date?.formatted(date: .abbreviated, time: .standard)
    }

    static func getHumanisedShortDate(apiDate: String) -> String? {
        let trimmedDate = apiDate.prefix(18) + "Z"
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: String(trimmedDate))

        return date?.formatted(date: .abbreviated, time: .omitted)
    }

    static func getHumanisedTime(apiDate: String) -> String? {
        let trimmedDate = apiDate.prefix(18) + "Z"
        let newFormatter = ISO8601DateFormatter()
        let date = newFormatter.date(from: String(trimmedDate))

        return date?.formatted(date: .omitted, time: .shortened)
    }

    static func getCustomFormattedDate(apiDate: String) -> String? {
        let trimmedDate = apiDate.prefix(18) + "Z"
        let newFormatter = ISO8601DateFormatter()
        guard let date = newFormatter.date(from: String(trimmedDate)) else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM HH:mm"
        return dateFormatter.string(from: date)
    }

    static func getCustomFormattedDay(apiDate: String) -> String? {
        let trimmedDate = apiDate.prefix(18) + "Z"
        let newFormatter = ISO8601DateFormatter()
        guard let date = newFormatter.date(from: String(trimmedDate)) else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMMM yyyy"
        return dateFormatter.string(from: date)
    }

    static func getCustomFormattedTime(apiDate: String) -> String? {
        let trimmedDate = apiDate.prefix(18) + "Z"
        let newFormatter = ISO8601DateFormatter()
        guard let date = newFormatter.date(from: String(trimmedDate)) else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    static func getLocalTimezone() -> String {
        guard let localTimezone = TimeZone.current.abbreviation() else {
            return ""
        }
        return localTimezone
    }

    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601)
            .date(from: Calendar(identifier: .iso8601)
                .dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        if hex.count == 6 {
            r = Double((int >> 16) & 0xFF) / 255.0
            g = Double((int >> 8) & 0xFF) / 255.0
            b = Double(int & 0xFF) / 255.0
        } else {
            r = 1
            g = 1
            b = 1
        }
        self.init(red: r, green: g, blue: b)
    }
}

extension Array: @retroactive RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data) else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return result
    }
}
