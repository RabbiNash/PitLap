//
//  YoutubeDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import Foundation
import PitlapKit

protocol YoutubeDataLogicType {
    func getVideos(title: String) async -> [YoutubeVideoModel]
}

final class YoutubeDataLogic: YoutubeDataLogicType {
    private let service: PitlapService
    
    init(service: PitlapService = Pitlap.shared.getService()) {
        self.service = service
    }
    
    func getVideos(title: String) async -> [YoutubeVideoModel] {
        do {
            return try await service.getYTVideos(channelName: title)
        } catch {
            print("Error loading videos summary \(error.localizedDescription)")
        }
        return []
    }
}

