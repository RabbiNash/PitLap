//
//  RaceWeekend.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import PersistenceManager

struct SeasonModel: Codable {
    let races: [RaceWeekendModel]
}

struct RaceWeekend: Codable, Hashable {
    let name, location: String
    let latitude, longitude: Double
    let round: Int
    let slug, localeKey: String
    let tbc: Bool
    let sessions: Sessions

    init(name: String, location: String, latitude: Double, longitude: Double, round: Int, slug: String, localeKey: String, tbc: Bool, sessions: Sessions) {
        self.name = name
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.round = round
        self.slug = slug
        self.localeKey = localeKey
        self.tbc = tbc
        self.sessions = sessions
    }
}

// MARK: - Sessions
struct Sessions: Codable, Hashable {
    let fp2, fp3, sprintQualifying, sprint: String?
    let fp1, qualifying: String
    let gp: String
}

// MARK: - RaceWeekendModel
struct RaceWeekendModel: Codable {
    let id: String = UUID().uuidString
    let round: Int
    let country, officialEventName, eventName: String
    let eventFormat: EventFormatModel
    let session1: Session1
    let session1DateUTC: String
    let session2: Session2
    let session2DateUTC: String
    let session3: Session3
    let session3DateUTC: String
    let session4: Session4
    let session4DateUTC: String
    let session5: Session5
    let session5DateUTC: String
    let year: String
    let results: [RaceResultModel]

    init(round: Int, country: String, officialEventName: String, eventName: String, eventFormat: EventFormatModel, session1: Session1, session1DateUTC: String, session2: Session2, session2DateUTC: String, session3: Session3, session3DateUTC: String, session4: Session4, session4DateUTC: String, session5: Session5, session5DateUTC: String, year: String, results: [RaceResultModel]) {
        self.round = round
        self.country = country
        self.officialEventName = officialEventName
        self.eventName = eventName
        self.eventFormat = eventFormat
        self.session1 = session1
        self.session1DateUTC = session1DateUTC
        self.session2 = session2
        self.session2DateUTC = session2DateUTC
        self.session3 = session3
        self.session3DateUTC = session3DateUTC
        self.session4 = session4
        self.session4DateUTC = session4DateUTC
        self.session5 = session5
        self.session5DateUTC = session5DateUTC
        self.year = year
        self.results = results
    }

    enum CodingKeys: String, CodingKey {
        case round, country, officialEventName, eventName, eventFormat, session1
        case session1DateUTC = "Session1DateUtc"
        case session2
        case session2DateUTC = "session2DateUtc"
        case session3
        case session3DateUTC = "session3DateUtc"
        case session4
        case session4DateUTC = "session4DateUtc"
        case session5
        case session5DateUTC = "session5DateUtc"
        case results
        case year
    }
}

// MARK: - Result
struct RaceResultModel: Codable {
    let position: Int
    let driver: String
    let headshotURL: String
    let points: Int
    let status: String
    let gridPosition: Int
    let teamColor, broadcastName, fullName: String

    enum CodingKeys: String, CodingKey {
        case position, driver
        case headshotURL = "headshotUrl"
        case points, status, gridPosition, teamColor, broadcastName, fullName
    }
}
