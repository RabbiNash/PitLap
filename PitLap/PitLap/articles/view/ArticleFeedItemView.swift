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
    private let feedItem: RSSFeedItem

    init(feedItem: RSSFeedItem) {
        self.feedItem = feedItem
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(feedItem.title ?? "")
                    .font(.custom("Titillium Web", size: 16))
                    .fontWeight(.bold)

                Text(feedItem.description ?? "")
                    .font(.custom("Titillium Web", size: 14))
                    .lineLimit(3)

                Text(Date.getHumanisedShortDateWithTime(date: feedItem.pubDate ?? .init()))
                    .foregroundColor(.secondary)
                    .padding(.top, 2)

                Spacer()
            }

            Spacer()

            KFImage(URL(string: feedItem.enclosure?.attributes?.url ?? feedItem.media?.thumbnails?.first?.attributes?.url ?? ""))
                .resizable()
                .cacheMemoryOnly()
                .roundCorner(
                    radius: .widthFraction(0.1),
                    roundingCorners: [.all]
                )
                .serialize(as: .PNG)
                .frame(width: 130, height: 100)
        }.frame(alignment: .leading)
    }
}
