//
//  VideoItem.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import SwiftUI
import Kingfisher

struct VideoItem: View {
    private let video: YoutubeVideoModel
    
    init(video: YoutubeVideoModel) {
        self.video = video
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: video.thumbnails.maxres?.url ?? video.thumbnails.high.url))
                .resizable()
                .cacheMemoryOnly()
                .serialize(as: .PNG)
                .frame(maxWidth: .infinity)
                .scaledToFit()
            
            Text(video.title)
                .font(.custom("Audiowide",size: 18))
                .fontWeight(.bold)
            
            Text(video.description)
                .padding(.top, 2)
                .lineLimit(5)
            
        }.padding(.vertical)
    }
}
