//
//  ArticleFeedItemView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import SwiftUI
import FeedKit
import Kingfisher

struct ArticleFeedItemView: View {
    private let feed: RSSFeedItem
    private let channel: RSSFeedChannel
    private let width: CGFloat = UIScreen.main.bounds.width - 32

    init(feed: RSSFeedItem, channel: RSSFeedChannel) {
        self.feed = feed
        self.channel = channel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: feed.enclosure?.attributes?.url ?? feed.media?.thumbnails?.first?.attributes?.url ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: UIScreen.main.bounds.height / 2)
                    .clipped()
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.black.opacity(0.4))
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(feed.title ?? "")
                        .font(.custom("Audiowide", size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .lineLimit(4)

                        HStack {
                            Image(systemName: "link")
                            Text(channel.title ?? "")
                                .lineLimit(1)
                                .font(.custom("Noto Sans", size: 12))

                        }
                        .foregroundColor(.white)
                        
                        Text(Date.getHumanisedShortDateWithTime(date: feed.pubDate ?? .init()))
                            .foregroundColor(.white)
                            .font(.custom("Noto Sans", size: 12))

                }
                .padding(12)
            }
        }
        .frame(width: width, height: UIScreen.main.bounds.height / 2)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
