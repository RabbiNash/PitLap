//
//  ArticleView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import SwiftUI
import Kingfisher
import PitlapKit

struct ArticleView: View {
    private let feed: RSSFeedItem

    init(feed: RSSFeedItem) {
        self.feed = feed
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                headerImage
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .clipped()

                articleMeta

                readMoreLink
                    .padding(.bottom, 32)

                Spacer()
            }.onAppear {
                Task {
                    RatingManager.shared.requestAppStoreRating()
                }
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
                    Text(feed.title)
                        .font(.custom("Audiowide", size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)

                    Text(feed.pubDate)
                        .foregroundColor(.white.opacity(0.85))
                        .font(.caption)

                    NavigationLink(destination: SafariView(url: articleURL)) {
                        Label(feed.channelTitle, systemImage: "link")
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

            Text(feed.description_)
                .styleAsBodyLarge()
                .padding(.horizontal)
        }
    }

    private var readMoreLink: some View {
        NavigationLink(destination: SafariView(url: articleURL)) {
            Text("Read more...")
                .styleAsBodyLarge()
                .foregroundColor(.accentColor)
                .padding(.horizontal)
        }
    }

    // MARK: - Helpers

    private var articleURL: URL {
        URL(string: feed.link)!
    }

    private var headerImageURL: URL? {
        URL(string: feed.imageUrl ?? "")
    }
}
