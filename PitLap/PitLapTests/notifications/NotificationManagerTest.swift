//
//  NotificationManagerTest.swift
//  PitLapTests
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation
import XCTest
@testable import PitLap

class NotificationManagerTests: XCTestCase {
    var mockNotificationCenter: MockUserNotificationCenter!
    var notificationManager: NotificationManager!

    override func setUp() {
        super.setUp()
        mockNotificationCenter = MockUserNotificationCenter()
        notificationManager = NotificationManager(notificationCenter: mockNotificationCenter)
    }

    func testScheduleNotifications() {
        let practiceSessionName = "Practice Session"
        let practiceSessionType = NotificationSessionType.session1
        let practiceEventDate = Date().addingTimeInterval(3600) // A time a hour from now
        let practiceAlertTime: TimeInterval = 900 // 15 minutes before the time

        let notificationPayload = NotificationPayload(
            eventDates: [practiceSessionType: [practiceSessionName: practiceEventDate]],
            selectedSessionAndTime: [practiceSessionType: [practiceAlertTime]]
        )

        notificationManager.scheduleNotifications(for: notificationPayload)

        XCTAssertEqual(mockNotificationCenter.addedRequests.count, 1, "Expected two notifications to be scheduled.")

        if let request = mockNotificationCenter.addedRequests.first {
            XCTAssertEqual(request.content.title, "\(practiceSessionName) \(practiceSessionType.rawValue) Reminder")
            XCTAssertEqual(request.identifier, "\(practiceSessionName) \(practiceSessionType.rawValue)_\(practiceAlertTime)")

            if let trigger = request.trigger as? UNCalendarNotificationTrigger,
               let triggerDate = Calendar.current.date(from: trigger.dateComponents) {
                let expectedTriggerDate = practiceEventDate.addingTimeInterval(-practiceAlertTime)
                XCTAssertEqual(triggerDate.timeIntervalSince1970, expectedTriggerDate.timeIntervalSince1970, accuracy: 100.0 , "Trigger date does not match expected date.")
            } else {
                XCTFail("Trigger is not of type UNCalendarNotificationTrigger.")
            }
        }
    }
}
