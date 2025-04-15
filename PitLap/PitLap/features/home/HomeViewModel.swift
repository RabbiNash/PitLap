//
//  HomeViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 08/04/2025.
//

import Foundation
import FeedKit
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
    @Published var autosportFeed: RSSFeedChannel?
    @Published var motorsportFeed: RSSFeedChannel?
    @Published var gpBlogsportFeed: RSSFeedChannel?
    @Published var raceFansFeed: RSSFeedChannel?
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

    func fetchHomePage() async {
        fetchStatus = .fetching
        
        async let _autosportFeed = feedDataLogic.getRSSFeed(from: FeedSource(rawValue: newsSource) ?? .autosport)
        async let _p1Videos = youtubeDataLogic.getVideos(title: F1YoutubeChannels.p1.rawValue)
        async let _peter = youtubeDataLogic.getVideos(title: F1YoutubeChannels.peter.rawValue)
        async let _kym = youtubeDataLogic.getVideos(title: F1YoutubeChannels.kym.rawValue)

        autosportFeed = await _autosportFeed
       
        let p1Videos = (await _p1Videos).prefix(5)
        let peterVideos = (await _peter).prefix(5)
        let kymVideos = (await _kym).prefix(5)

        videos = (p1Videos + peterVideos + kymVideos).shuffled()
        
        fetchStatus = .success
    }
}

