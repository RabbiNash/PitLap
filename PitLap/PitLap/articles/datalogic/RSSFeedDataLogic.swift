//
//  RSSFeedDataLogic.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import Foundation
import FeedKit

enum FeedSource: String, CaseIterable {
    case bbc = "https://feeds.bbci.co.uk/sport/formula1/rss.xml"
    case autosport = "https://www.autosport.com/rss/f1/news/"
    case gbblog = "https://www.gpblog.com/en/rss/index.xml"
    case motosportcom = "https://www.motorsport.com/rss/f1/news/"
    case racefans = "https://www.racefans.net/feed/"
    
    var title: String {
        switch self {
        case .bbc:
            "BBC"
        case .autosport:
            "Autosport"
        case .gbblog:
            "GPBlog"
        case .motosportcom:
            "Motosport.com"
        case .racefans:
            "Racefans"
        }
    }
}

protocol RSSFeedDataLogicType {
    func getRSSFeed(from feedSource: FeedSource) async -> RSSFeedChannel?
}

final class RSSFeedDataLogic: RSSFeedDataLogicType {

    func getRSSFeed(from feedSource: FeedSource) async -> RSSFeedChannel? {
        let feed = try? await RSSFeed(urlString: feedSource.rawValue)
        return feed?.channel
    }
}
