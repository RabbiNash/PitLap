//
//  NotificationPreferences.swift
//  PitLap
//
//  Created by Tinashe Makuti on 23/02/2025.
//

import Foundation

struct NotificationPreferences: Codable {
    var enabled: Bool
    var triggerEvents: [NotificationTriggerEvent]
    var sessionTypes: [NotificationSessionType]
    var topics: [NotificationTopic]
}
