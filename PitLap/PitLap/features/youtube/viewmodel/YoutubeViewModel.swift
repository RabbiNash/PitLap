//
//  YoutubeViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import Foundation
import PitlapKit

final class YoutubeViewModel: ObservableObject {
    private let dataLogic: YoutubeDataLogicType
    
    @Published var isLoading: Bool = false
    @Published var videos: [YoutubeVideoModel] = []
    @Published var selectedChannel: F1YoutubeChannels = .p1

    init(dataLogic: YoutubeDataLogicType = YoutubeDataLogic()) {
        self.dataLogic = dataLogic
    }

    func fetchVideos(title: String, forceRefresh: Bool = false) {
        Task {
            await fetchVideos(title: title, forceRefresh: forceRefresh)
        }
    }
    
    @MainActor
    private func fetchVideos(title: String, forceRefresh: Bool) async {
        isLoading = true
        defer {
            isLoading = false
        }
            
        videos = await self.dataLogic.getVideos(title: title, forceRefresh: forceRefresh)
    }
}
