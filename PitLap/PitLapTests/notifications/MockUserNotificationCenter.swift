//
//  MockUserNotificationCenter.swift
//  PitLapTests
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation
import UserNotifications
@testable import PitLap

class MockUserNotificationCenter: UserNotificationCenterType {
    var addedRequests: [UNNotificationRequest] = []

    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)? = nil) {
        addedRequests.append(request)
        completionHandler?(nil)
    }
}
