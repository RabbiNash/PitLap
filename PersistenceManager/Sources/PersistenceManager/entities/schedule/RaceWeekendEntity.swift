//
//  SeasonEntity.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 17/01/2025.
//

import Foundation
import SwiftData

@Model
public final class RaceWeekendEntity: Identifiable {
    @Attribute(.unique) var uuid: String
    public var round: Int
    public var country: String
    public var officialEventName: String
    public var eventName: String
    public var eventFormat: EventFormatModel
    public var session1: Session1
    public var session1DateUTC: String
    public var session2: Session2
    public var session2DateUTC: String
    public var session3: Session3
    public var session3DateUTC: String
    public var session4: Session4
    public var session4DateUTC: String
    public var session5: Session5
    public var session5DateUTC: String
    public var year: String
    public var results: [RaceResultEntity] = []
    public var key: String

    public init(
        uuid: String,
        round: Int,
        country: String,
        officialEventName: String,
        eventName: String,
        eventFormat: EventFormatModel,
        session1: Session1,
        session1DateUTC: String,
        session2: Session2,
        session2DateUTC: String,
        session3: Session3,
        session3DateUTC: String,
        session4: Session4,
        session4DateUTC: String,
        session5: Session5,
        session5DateUTC: String,
        year: String,
        results: [RaceResultEntity] = []
    ) {
        self.uuid = uuid
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
        self.key = "\(round)-\(year)"
    }
}

// MARK: - RaceResultModel
@Model
public final class RaceResultEntity {
    public var position: Int
    public var driver: String
    public var headshotURL: String
    public var points: Int
    public var status: String
    public var gridPosition: Int
    public var teamColor: String
    public var broadcastName: String
    public var fullName: String

    public init(
        position: Int,
        driver: String,
        headshotURL: String,
        points: Int,
        status: String,
        gridPosition: Int,
        teamColor: String,
        broadcastName: String,
        fullName: String
    ) {
        self.position = position
        self.driver = driver
        self.headshotURL = headshotURL
        self.points = points
        self.status = status
        self.gridPosition = gridPosition
        self.teamColor = teamColor
        self.broadcastName = broadcastName
        self.fullName = fullName
    }
}

public enum Session1: String, Codable {
    case practice1 = "Practice 1"
}

public enum Session2: String, Codable {
    case practice2 = "Practice 2"
    case sprintQualifying = "Sprint Qualifying"
}

public enum Session3: String, Codable {
    case practice3 = "Practice 3"
    case sprint = "Sprint"
}

public enum Session4: String, Codable {
    case none = "None"
    case qualifying = "Qualifying"
}

public enum Session5: String, Codable {
    case none = "None"
    case race = "Race"
}

public enum EventFormatModel: String, Codable {
    case conventional = "conventional"
    case sprintQualifying = "sprint_qualifying"
    case testing = "testing"
}
