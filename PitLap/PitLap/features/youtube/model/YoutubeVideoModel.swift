//
//  YoutubeVideoModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import Foundation

// MARK: - Welcome
struct YoutubeVideoModel: Codable, Equatable {
    static func == (lhs: YoutubeVideoModel, rhs: YoutubeVideoModel) -> Bool {
        lhs.resourceID.videoID == rhs.resourceID.videoID
    }
    
    let thumbnails: Thumbnails
    let resourceID: MediaResource
    let id: String
    let v: Int
    let channelID, channelTitle, description, playlistID: String
    let position: Int
    let publishedAt: String
    let title, updatedAt, videoOwnerChannelID, videoOwnerChannelTitle: String

    enum CodingKeys: String, CodingKey {
        case thumbnails
        case resourceID = "resourceId"
        case id = "_id"
        case v = "__v"
        case channelID = "channelId"
        case channelTitle, description
        case playlistID = "playlistId"
        case position, publishedAt, title, updatedAt
        case videoOwnerChannelID = "videoOwnerChannelId"
        case videoOwnerChannelTitle
    }
}

struct MediaResource: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: ThumbnailDetails
    let maxres: ThumbnailDetails?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

struct ThumbnailDetails: Codable {
    let url: String
    let width, height: Int
}
