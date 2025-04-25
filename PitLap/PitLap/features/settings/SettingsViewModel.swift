//
//  SettingsViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import SwiftUI
import PitlapKit
import FirebaseMessaging

final class SettingsViewModel: ObservableObject {
    @AppStorage("selectedTeam") private var selectedTeam: String = F1Team.ferrari.rawValue
    @AppStorage("newsSource") private var newsSource: String = FeedSource.autosport.rawValue
    @AppStorage("isDarkMode") private var isDarkMode = true
    @AppStorage("enableNotifications") private var enableNotifications = false
    @AppStorage("selectedNotificationTimes") private var selectedNotificationTimes: [NotificationTriggerEvent] = []
    @AppStorage("selectedNotificationEvents") private var selectedNotificationEvents: [NotificationSessionType] = []
    @AppStorage("selectedNotificationTopics") private var selectedNotificationTopics: [NotificationTopic] = []
    
    @AppStorage("onboardingCompleted") private var onboardingCompleted: Bool = false

    @Published var userSelectedTimes: [NotificationTriggerEvent] = []
    @Published var userSelectedEvents: [NotificationSessionType] = []
    @Published var notificationTopics: [NotificationTopic] = []
    @Published var team: String
    @Published var source: String
    @Published var darkMode: Bool
    @Published var notifications: Bool

    let availableTimes = NotificationTriggerEvent.allCases
    let allEvents = NotificationSessionType.allCases
    
    private let appIconService: AppIconServiceType
    private let notificationManager: NotificationManagerType
    private let firebaseService: FirebaseServiceType
    private let scheduleDataLogic: RaceCalendarDataLogicType

    init(
        appIconService: AppIconServiceType = AppIconService(),
        notificationManager: NotificationManagerType = NotificationManager(),
        firebaseService: FirebaseServiceType = FirebaseService(),
        scheduleDataLogic: RaceCalendarDataLogicType = RaceCalendarDataLogic()
    ) {
        self.appIconService = appIconService
        self.notificationManager = notificationManager
        (team, source, darkMode, notifications, userSelectedTimes, userSelectedEvents, notificationTopics) = (
            _selectedTeam.wrappedValue,
            _newsSource.wrappedValue,
            _isDarkMode.wrappedValue,
            _enableNotifications.wrappedValue,
            _selectedNotificationTimes.wrappedValue,
            _selectedNotificationEvents.wrappedValue,
            _selectedNotificationTopics.wrappedValue
        )
        self.firebaseService = firebaseService
        self.scheduleDataLogic = scheduleDataLogic
    }

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var appBuild: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "RC"
    }

    func didTapConfirm() {
//        scheduleNotifications()
        updateAppIconIfNeeded()
        subscribeToTopics()
        completeOnboarding()
        
        selectedTeam = team
        newsSource = source
        isDarkMode = darkMode
        enableNotifications = notifications
        selectedNotificationTimes = userSelectedTimes
        selectedNotificationEvents = userSelectedEvents
        selectedNotificationTopics = notificationTopics
    }
    
    //MARK: Settings
    private func updateAppIconIfNeeded() {
        guard selectedTeam != team, let iconName = F1Team(rawValue: team)?.iconName else { return }
        appIconService.updateAppIcon(to: iconName) { error in
            print(error?.localizedDescription ?? "App icon updated successfully!")
        }
    }
    
    //MARK: Notification Topics
    private func subscribeToTopics() {
        firebaseService.subscribe(to: notificationTopics)
    }
    
    private func unsubscribeToTopics() {
        firebaseService.unsubscribe(from: selectedNotificationTopics)
    }
    
    //MARK: Notifications
//    private func scheduleNotifications() {
//        clearPendingNotifications()
//        let selectedSessionAndTime = userSelectedEvents.reduce(into: [:]) {
//            $0[$1] = userSelectedTimes.map(\.extraData)
//        }
//        
//        let events = scheduleDataLogic.getRaceCalendar(for: 2025)
//
//        let eventDates = userSelectedEvents.reduce(into: [:]) { dict, event in
//            dict[event] = raceWeekends.reduce(into: [:]) { dates, weekend in
//                dates[weekend.eventName] = sessionDate(for: event, in: weekend)
//            }
//        }
//
//        notificationManager.scheduleNotifications(for: .init(
//            eventDates: eventDates,
//            selectedSessionAndTime: selectedSessionAndTime
//        ))
//    }
    
    func clearPendingNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

extension SettingsViewModel {
    private func sessionDate(for event: NotificationSessionType, in weekend: EventScheduleModel) -> Date? {
        let isSprint = weekend.eventFormat != "conventional"
        let dateString: String? = {
            switch (event, isSprint) {
            case (.session1, _): return weekend.session1DateUTC
            case (.session2, false): return weekend.session2DateUTC
            case (.session3, false): return weekend.session3DateUTC
            case (.session4, _): return weekend.session4DateUTC
            case (.session5, _): return weekend.session5DateUTC
            case (.session6, true): return weekend.session2DateUTC
            case (.session7, true): return weekend.session3DateUTC
            default: return nil
            }
        }()
        return dateString.flatMap(Date.getDateFromString)
    }
}

extension SettingsViewModel {
    func completeOnboarding() {
        onboardingCompleted = true
        selectedTeam = team
    }
}
