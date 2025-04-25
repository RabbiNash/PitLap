//
//  ArticleFeedViewModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import Foundation
import SwiftUI
import PitlapKit


final class ArticleFeedViewModel: ObservableObject {
    @Published var articles: [RSSFeedItem] = []
    @Published var isLoading: Bool = false
    @Published var state: ViewState = .loading

    private let feedDataLogic: RSSFeedDataLogicType

    init(feedDataLogic: RSSFeedDataLogicType = RSSFeedDataLogic()) {
        self.feedDataLogic = feedDataLogic
    }

    @MainActor
    func getFeed(from source: FeedSource, forceRefresh: Bool = false) async {
        isLoading = true
        articles = await feedDataLogic.getArticlesFeed(from: source, forceRefresh: forceRefresh)
        state = !articles.isEmpty ? .success(articles) : .error
        isLoading = false
    }

    enum ViewState {
        case loading
        case success([RSSFeedItem])
        case error
    }
}

