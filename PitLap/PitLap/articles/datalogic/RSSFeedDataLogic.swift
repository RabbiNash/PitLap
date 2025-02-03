//
//  RSSFeedDataLogic.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import Foundation
import FeedKit

enum FeedSource: String {
    case bbc = "https://feeds.bbci.co.uk/sport/formula1/rss.xml"
    case autosport = "https://www.autosport.com/rss/f1/news/"
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
