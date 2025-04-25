//
//  RSSFeedDataLogic.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import Foundation
import PitlapKit

enum FeedSource: String, CaseIterable {
    case bbc = "https://feeds.bbci.co.uk/sport/formula1/rss.xml"
    case autosport = "https://www.autosport.com/rss/f1/news/"
    case gbblog = "https://www.gpblog.com/en/rss/index.xml"
    case motosportcom = "https://www.motorsport.com/rss/f1/news/"
    case racefans = "https://www.racefans.net/feed/"
    case fia = "https://www.fia.com/rss/news"
    
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
        case .fia:
            "FIA"
        }
    }
}

protocol RSSFeedDataLogicType {
    func getArticlesFeed(from feedSource: FeedSource, forceRefresh: Bool) async -> [RSSFeedItem]
    func getArticle(by id: String) async -> RSSFeedItem?
}

final class RSSFeedDataLogic: RSSFeedDataLogicType {
    private let service: PitlapService
    
    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }

    func getArticlesFeed(from feedSource: FeedSource, forceRefresh: Bool) async -> [RSSFeedItem] {
        let feed = try? await service.getFeedArticles(feedUrl: feedSource.rawValue, forceRefresh: forceRefresh)
        return feed ?? []
    }
    
    func getArticle(by id: String) async -> RSSFeedItem? {
        return try? await service.getArticleFeedById(id: id)
    }
}
