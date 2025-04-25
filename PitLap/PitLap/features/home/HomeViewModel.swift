//
//  HomeViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 08/04/2025.
//

import Foundation
import SwiftUI
import PitlapKit

@MainActor
final class HomeViewModel: ObservableObject {
    
    @AppStorage("newsSource") private var newsSource: String = FeedSource.autosport.rawValue

    enum FetchStatus {
        case nonStarted
        case fetching
        case success
        case failed(error: Error)
    }

    private let standingsDataLogic: StandingsDataLogicType
    private let feedDataLogic: RSSFeedDataLogicType
    private let youtubeDataLogic: YoutubeDataLogicType

    private(set) var fetchStatus: FetchStatus = .nonStarted
    
    @Published var leadDriver: DriverStandingModel?
    @Published var feed: [RSSFeedItem] = []
    @Published var videos: [YoutubeVideoModel] = []

    init(
        standingsDataLogic: StandingsDataLogicType = StandingsDataLogic(),
        feedDataLogic: RSSFeedDataLogicType = RSSFeedDataLogic(),
        youtubeDataLogic: YoutubeDataLogicType = YoutubeDataLogic()
    ) {
        self.standingsDataLogic = standingsDataLogic
        self.feedDataLogic = feedDataLogic
        self.youtubeDataLogic = youtubeDataLogic
    }

    func fetchHomePage(forceRefresh: Bool = false) async {
        fetchStatus = .fetching
        
        async let _autosportFeed = feedDataLogic.getArticlesFeed(from: FeedSource(rawValue: newsSource) ?? .autosport, forceRefresh: forceRefresh)
        async let _videos = youtubeDataLogic.getRankedVideos(forceRefresh: forceRefresh)

        feed = await _autosportFeed
        videos = await _videos
        
        fetchStatus = .success
    }
}

