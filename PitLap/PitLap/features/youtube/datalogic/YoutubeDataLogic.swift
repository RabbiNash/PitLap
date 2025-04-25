//
//  YoutubeDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import Foundation
import PitlapKit

protocol YoutubeDataLogicType {
    func getVideos(title: String, forceRefresh: Bool) async -> [YoutubeVideoModel]
    func getRankedVideos(forceRefresh: Bool) async -> [YoutubeVideoModel]
}

final class YoutubeDataLogic: YoutubeDataLogicType {
    
    private let service: PitlapService
    
    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }
    
    func getVideos(title: String, forceRefresh: Bool) async -> [YoutubeVideoModel] {
        do {
            return try await service.getYTVideos(channelName: title, forceRefresh: forceRefresh)
        } catch {
            print("Error loading videos summary \(error.localizedDescription)")
        }
        return []
    }
    
    func getRankedVideos(forceRefresh: Bool = false) async -> [YoutubeVideoModel] {
        do {
            return try await service.getRankedVideos(forceRefresh: forceRefresh)
        } catch {
            print("Error loading videos summary \(error.localizedDescription)")
        }
        return []
    }
}

