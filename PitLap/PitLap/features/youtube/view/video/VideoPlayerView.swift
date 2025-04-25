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
            VStack(alignment: .leading) {
                PlayerView(videoId: video.videoId)
                    .frame(height: 300)
                    .cornerRadius(8)

                Text(video.title)
                    .font(.custom("Audiowide",size: 16))
                    .fontWeight(.bold)
                    .bold()
                    .padding(.top, 10)

                Text(video.description_)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
            }
            .padding()
        }
        .navigationTitle("Formula 1")
        .navigationBarTitleDisplayMode(.inline)
    }
}
