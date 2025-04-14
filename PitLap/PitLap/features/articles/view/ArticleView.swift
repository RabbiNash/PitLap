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
    private let feed: RSSFeedItem
    private let channelTitle: String

    init(feed: RSSFeedItem, channelTitle: String) {
        self.feed = feed
        self.channelTitle = channelTitle
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                headerImage
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .clipped()

                articleMeta

                Text(truncatedDescription)
                    .font(.custom("Noto Sans", size: 16))
                    .padding(.horizontal)

                readMoreLink
                    .padding(.bottom, 32)

                Spacer()
            }
        }
        .ignoresSafeArea(edges: .top)
    }

    // MARK: - Subviews

    private var headerImage: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                KFImage(headerImageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .overlay(Color.black.opacity(0.5))
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(feed.title ?? "No Title")
                        .font(.custom("Audiowide", size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)

                    Text(Date.getHumanisedShortDateWithTime(date: feed.pubDate ?? Date()))
                        .foregroundColor(.white.opacity(0.85))
                        .font(.caption)

                    NavigationLink(destination: SafariView(url: articleURL)) {
                        Label(channelTitle, systemImage: "link")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
                .padding()
            }
        }
    }

    private var articleMeta: some View {
        VStack(alignment: .leading, spacing: 8) {
            Divider().padding(.horizontal)

            if let description = feed.description?.replacingOccurrences(of: "<br>", with: "\n\n") {
                Text(description)
                    .font(.custom("Noto Sans", size: 16))
                    .padding(.horizontal)
            }
        }
    }

    private var readMoreLink: some View {
        NavigationLink(destination: SafariView(url: articleURL)) {
            Text("Read more...")
                .font(.custom("Noto Sans", size: 16))
                .foregroundColor(.accentColor)
                .padding(.horizontal)
        }
    }

    // MARK: - Helpers

    private var articleURL: URL {
        URL(string: feed.link ?? "https://formula1.com")!
    }

    private var headerImageURL: URL? {
        URL(string: feed.enclosure?.attributes?.url
             ?? feed.media?.thumbnails?.first?.attributes?.url
             ?? "")
    }

    private var truncatedDescription: String {
        guard let description = feed.description else { return "" }
        let cleaned = description.replacingOccurrences(of: "<br>", with: "\n\n")
        guard let range = cleaned.range(of: "...") else { return cleaned }
        return String(cleaned[..<range.upperBound])
    }
}
