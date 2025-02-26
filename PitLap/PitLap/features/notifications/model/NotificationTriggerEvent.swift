//
//  NotificationFrequency.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation

enum NotificationTriggerEvent: String, CaseIterable, Codable, MultiSelectionType {
    typealias T = TimeInterval
    
    
    var id: Self { self }
    
    case fifteenMinutes
    case hour
    case day
    
    var title: String {
        switch self {
        case .fifteenMinutes:
            "15 Mins"
        case .hour:
            "1 Hour"
        case .day:
            "1 Day"
        }
    }
    
    var extraData: TimeInterval {
        switch self {
        case .fifteenMinutes:
            86400
        case .hour:
            3600
        case .day:
            900
        }
    }
}

enum NotificationTopic: String, CaseIterable, Codable, MultiSelectionType {
    typealias T = Void

    var id: Self { self }
    
    case practice
    case qualifying
    case sprintQualifying
    case sprint
    case race

    var title: String {
        switch self {
        case .practice:
            "Practice"
        case .qualifying:
            "Qualifying"
        case .sprintQualifying:
            "Sprint Qualifying"
        case .sprint:
            "Sprint"
        case .race:
            "Race"
        }
    }
    
    var extraData: Void {
        ()
    }
}

protocol MultiSelectionType: Identifiable, Hashable {
    associatedtype T
    
    var title: String { get }
    var extraData: T { get }
}

