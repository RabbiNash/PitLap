//
//  YoutubeViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import Foundation

final class YoutubeViewModel: ObservableObject {
    private let dataLogic: YoutubeDataLogicType
    
    @Published var isLoading: Bool = false
    @Published var videos: [YoutubeVideoModel] = []
    @Published var selectedChannel: F1YoutubeChannels = .formula1

    init(dataLogic: YoutubeDataLogicType = YoutubeDataLogic()) {
        self.dataLogic = dataLogic
    }

    func fetchVideos(title: String) {
        Task {
            await fetchVideos(title: title)
        }
    }
    
    @MainActor
    private func fetchVideos(title: String) async {
        isLoading = true
        defer {
            isLoading = false
        }
            
        videos = await self.dataLogic.getVideos(title: title)
    }
}
