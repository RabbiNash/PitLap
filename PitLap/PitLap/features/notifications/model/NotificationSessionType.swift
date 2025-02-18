//
//  NotificationSessionType.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation
import PersistenceManager

enum NotificationSessionType: String, CaseIterable, Identifiable, Codable, MultiSelectionType {
    typealias T = Void
    
    case session1, session2, session3, session4, session5, session6, session7
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .session1:
            return "Practice 1"
        case .session2:
            return "Practice 2"
        case .session3:
            return "Practice 3"
        case .session4:
            return "Qualifying"
        case .session5:
            return "Race"
        case .session6:
            return "Sprint Qualifying"
        case .session7:
            return "Sprint Race"
        }
    }
    
    var extraData: Void {
        ()
    }
}
