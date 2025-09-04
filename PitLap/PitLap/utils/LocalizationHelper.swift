//
//  LocalizationHelper.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation

extension String {
    /// Returns the localized version of the string
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns the localized version of the string with arguments
    func localized(_ arguments: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }
}

// MARK: - Localized String Constants
struct LocalizedStrings {
    // MARK: - App Name
    static let appName = "app.name".localized
    
    // MARK: - Tab Navigation
    static let home = "tab.home".localized
    static let seasons = "tab.seasons".localized
    static let standings = "tab.standings".localized
    static let trivia = "tab.trivia".localized
    
    // MARK: - Settings
    static let preferences = "settings.title".localized
    static let team = "settings.team".localized
    static let newsSource = "settings.news_source".localized
    static let darkMode = "settings.dark_mode".localized
    static let notifications = "settings.notifications".localized
    static let enableNotifications = "settings.enable_notifications".localized
    static let settings = "settings.settings".localized
    static let confirm = "settings.confirm".localized
    static let version = "settings.version".localized
    static let disclaimer = "settings.disclaimer".localized
    
    // MARK: - Onboarding
    static let onboardingTitle = "onboarding.title".localized
    static let onboardingSubtitle = "onboarding.subtitle".localized
    
    // MARK: - Home
    static let trendingNews = "home.trending_news".localized
    static let latestVideos = "home.latest_videos".localized
    static let position = "home.position".localized
    static let points = "home.points".localized
    
    // MARK: - Calendar
    static let calendar = "calendar.title".localized
    static let viewPastEvents = "calendar.view_past_events".localized
    static let sessionWeather = "calendar.session_weather".localized
    static let raceDayWeather = "calendar.race_day_weather".localized
    static let raceSummary = "calendar.race_summary".localized
    static let trackFacts = "calendar.track_facts".localized
    static let comingSoon = "calendar.coming_soon".localized
    static let invalidYear = "calendar.invalid_year".localized
    
    // MARK: - Race Results
    static let qualifyingResult = "race.qualifying_result".localized
    static let raceResult = "race.race_result".localized
    
    // MARK: - YouTube
    static let selectChannel = "youtube.select_channel".localized
    
    // MARK: - Trivia
    static let triviaTitle = "trivia.title".localized
    
    // MARK: - Common
    static let link = "common.link".localized
    static let none = "common.none".localized
    
    // MARK: - Helper Methods
    static func round(_ roundNumber: Int) -> String {
        return "calendar.round".localized(roundNumber)
    }
    
    static func version(_ version: String, _ build: String) -> String {
        return "settings.version".localized(version, build)
    }
}
