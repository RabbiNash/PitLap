//
//  NotificationPayload.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation

struct NotificationPayload {
    let eventDates: [NotificationSessionType: [String: Date?]]
    let selectedSessionAndTime: [NotificationSessionType: [TimeInterval]]
}
