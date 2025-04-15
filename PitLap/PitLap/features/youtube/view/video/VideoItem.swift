//
//  VideoItem.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import SwiftUI
import Kingfisher
import PitlapKit

struct VideoItem: View {
    private let video: YoutubeVideoModel
    
    init(video: YoutubeVideoModel) {
        self.video = video
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: video.thumbnailUrl ?? ""))
                .resizable()
                .cacheMemoryOnly()
                .serialize(as: .PNG)
                .cornerRadius(8)
                .frame(maxWidth: .infinity)
                .scaledToFit()
            
            Text(video.title)
                .font(.custom("Audiowide",size: 18))
                .fontWeight(.bold)
                .lineLimit(3)
            
        }.padding(.vertical)
    }
}
