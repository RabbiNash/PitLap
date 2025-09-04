//
//  YouTubePlayerView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import SwiftUI
import PitlapKit

struct VideoPlayerDescriptionView: View {
    private let video: YoutubeVideoModel
    
    init(video: YoutubeVideoModel) {
        self.video = video
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                
                PlayerView(videoId: video.videoId)
                    .aspectRatio(16.0/9.0, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Text(video.title)
                    .font(.custom("Audiowide", size: 18))
                    .fontWeight(.bold)
                    .lineLimit(nil)
                
                Text(video.description_)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal)
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(UIColor.systemBackground))
        .navigationTitle("Formula 1")
        .navigationBarTitleDisplayMode(.inline)
    }
}
