//
//  NotificationManager.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation
import UserNotifications

protocol NotificationManagerType {
    func scheduleNotifications(for notificationPayload: NotificationPayload)
}

final class NotificationManager: NotificationManagerType {
    private let notificationCenter: UserNotificationCenterType
    
    init(notificationCenter: UserNotificationCenterType = UNUserNotificationCenter.current()) {
        self.notificationCenter = notificationCenter
    }
    
    func scheduleNotifications(for notificationPayload: NotificationPayload) {
        for (sessionType, sessions) in notificationPayload.eventDates {
            guard let alertTimes = notificationPayload.selectedSessionAndTime[sessionType] else { continue }
            for (sessionName, eventDate) in sessions {
                guard let eventDate = eventDate else { return }
                alertTimes.forEach { alertTime in
                    scheduleNotification(for: "\(sessionName) \(sessionType.title)", at: eventDate, alertTime: alertTime)
                }
            }
        }
    }
    
    private func scheduleNotification(for session: String, at eventDate: Date, alertTime: TimeInterval) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .full
        
        let sessionTime = formatter.string(from: alertTime) ?? "some time"
        
        let content = UNMutableNotificationContent()
        content.title = "\(session) Reminder"
        content.body = "Don't miss the \(session) session! It starts in \(sessionTime)."
        content.sound = .default
        
        let triggerDate = eventDate.addingTimeInterval(-alertTime)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate),
            repeats: false
        )
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}

protocol UserNotificationCenterType {
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)?)
}

extension UNUserNotificationCenter: UserNotificationCenterType {}
