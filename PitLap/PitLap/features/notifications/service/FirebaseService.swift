//
//  FirebaseServiceType.swift
//  PitLap
//
//  Created by Tinashe Makuti on 23/02/2025.
//

import FirebaseMessaging

protocol FirebaseServiceType {
    func subscribe(to topics: [NotificationTopic])
    func unsubscribe(from topics: [NotificationTopic])
}

final class FirebaseService: FirebaseServiceType {
    
    private let messaging: Messaging
    
    init(messaging: Messaging = .messaging()) {
        self.messaging = messaging
    }
    
    func subscribe(to topics: [NotificationTopic]) {
        unsubscribe(from: NotificationTopic.allCases)
        topics.forEach { topic in
            messaging.subscribe(toTopic: topic.rawValue) { error in
                if let error = error {
                    print("Error subscribing to \(topic): \(error.localizedDescription)")
                }
            }
        }
    }
    
    func unsubscribe(from topics: [NotificationTopic]) {
        topics.forEach { topic in
            messaging.unsubscribe(fromTopic: topic.rawValue) { error in
                if let error = error {
                    print("Error unsubscribing from \(topic): \(error.localizedDescription)")
                }
            }
        }
    }
}
