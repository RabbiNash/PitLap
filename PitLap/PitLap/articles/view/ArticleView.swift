//
//  ArticleView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import SwiftUI
import FeedKit
import Kingfisher

struct ArticleView: View {
    @Environment(\.openURL) var openURL
    private let feed: RSSFeedItem

    init(feed: RSSFeedItem) {
        self.feed = feed
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    KFImage(URL(string: feed.enclosure?.attributes?.url ?? feed.media?.thumbnails?.first?.attributes?.url ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.black.gradient.opacity(0.6))
                        )

                    VStack(alignment: .leading) {
                        Text(feed.title ?? "")
                            .font(.custom("Formula1", size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text(Date.getHumanisedShortDateWithTime(date: feed.pubDate ?? .init()))
                            .foregroundColor(.white)
                            .padding(.top, 2)

                        HStack {
                            Image(systemName: "link")
                            Text("Autosport.com")
                        }
                        .foregroundColor(.white)
                        .onTapGesture {
                            openURL(URL(string: feed.link ?? "")!)
                        }
                    }
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                }
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 2)

            let truncatedDescription = truncateAfterEllipsis(feed.description?.replacingOccurrences(of: "<br>", with: "\n\n")  ?? "")

            Text(truncatedDescription)
                .font(.custom("Titillium Web", size: 16))
                .padding(.top, 8)
                .padding(.horizontal, 16)

            Text("Read more...")
                .font(.custom("Titillium Web", size: 16))
                .foregroundColor(.accentColor)
                .padding(.top, 8)
                .padding(.horizontal, 16)
                .onTapGesture {
                    openURL(URL(string: feed.link ?? "")!)
                }

            Spacer()
        }
    }

    private func truncateAfterEllipsis(_ input: String) -> String {
        guard let range = input.range(of: "...") else { return input }
        return String(input[input.startIndex..<range.upperBound])
    }

}

#Preview {
    ArticleView(feed: .init())
}
