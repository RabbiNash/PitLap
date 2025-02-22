//
//  YoutubeDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import Foundation

protocol YoutubeDataLogicType {
    func getVideos(title: String) async -> [YoutubeVideoModel]
}

final class YoutubeDataLogic: YoutubeDataLogicType {
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiServiceImpl.shared) {
        self.apiService = apiService
    }
    
    func getVideos(title: String) async -> [YoutubeVideoModel] {
        do {
            return try await apiService.fetchYoutubeVideos(channelTitle: title)
        } catch {
            print("Error loading videos summary \(error.localizedDescription)")
        }
        return []
    }
}

