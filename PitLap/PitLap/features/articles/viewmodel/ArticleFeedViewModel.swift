//
//  ArticleFeedViewModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import Foundation
import FeedKit
import SwiftUI

@MainActor
final class ArticleFeedViewModel: ObservableObject {
    @Published var feedChannel: RSSFeedChannel? = .init()
    @Published var isLoading: Bool = false
    @Published var state: ViewState = .loading

    private let feedDataLogic: RSSFeedDataLogicType

    init(feedDataLogic: RSSFeedDataLogicType = RSSFeedDataLogic()) {
        self.feedDataLogic = feedDataLogic
    }

    func getFeed(from source: FeedSource) async {
        isLoading = true
        feedChannel = await feedDataLogic.getRSSFeed(from: source)
        state = feedChannel != nil ? .success(feedChannel!) : .error
        isLoading = false
    }

    enum ViewState {
        case loading
        case success(RSSFeedChannel)
        case error
    }
}

