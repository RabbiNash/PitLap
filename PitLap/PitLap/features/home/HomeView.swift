//
//  HomeView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 03/04/2025.
//

import SwiftUI
import FeedKit
import PitlapKit

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @State private var hasFetchedData = false
    
    var body: some View {
        NavigationStack {
            switch viewModel.fetchStatus {
            case .nonStarted:
                progressView
            case .fetching:
                progressView
            case .success:
                content
            case .failed:
                EmptyView()
            }
        }.onAppear {
            if !hasFetchedData {
               Task { @MainActor in
                   await viewModel.fetchHomePage()
                   hasFetchedData = true
               }
           }
        }
    }
    
    @ViewBuilder
    var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Trending News")
                    .font(.custom("Audiowide", size: 20))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .background(
                        ThemeManager.shared.selectedTeamColor
                            .frame(height: 2)
                            .offset(y: 20)
                    )
                    .padding(.leading, 16)
                
                articleHorizontalList(feedChannel: viewModel.autosportFeed)
                
                Text("Latest Videos")
                    .font(.custom("Audiowide", size: 20))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .background(
                        ThemeManager.shared.selectedTeamColor
                            .frame(height: 2)
                            .offset(y: 20)
                    )
                    .padding(.leading, 16)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)) {
                    ForEach(viewModel.videos, id: \.videoId) { item in
                        NavigationLink(destination: VideoPlayerDescriptionView(video: item)) {
                            VideoItem(video: item)
                        }.buttonStyle(.plain)
                    }
                }.padding(.horizontal)
                
            }
            .padding(.vertical)
        }
        .refreshable {
            Task { @MainActor in
                await viewModel.fetchHomePage()
                hasFetchedData = true
            }
        }
    }
    
    @ViewBuilder
    func articleHorizontalList(feedChannel: RSSFeedChannel?) -> some View {
        VStack(alignment: .center, spacing: 12) {
            if let channel = feedChannel {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(feedChannel?.items ?? [], id: \.guid) { item in
                            NavigationLink(destination: ArticleView(feed: item, channelTitle: feedChannel?.title ?? "" )) {
                                ArticleFeedItemView(feed: item, channel: channel)
                            }.buttonStyle(.plain)
                        }
                    }
                }.contentMargins(.leading, 16)
            }
        }
    }
    
    @ViewBuilder
    func standingsHeader(driver: DriverStandingModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(ThemeManager.shared.selectedTeamColor.gradient)
                .shadow(radius: 6)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 4) {
                    Text(driver.givenName)
                    Text(driver.familyName)
                        .bold()
                }
                .font(.custom("Audiowide", size: 24))
                .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Pos")
                            .foregroundColor(.white.opacity(0.7))
                        Text(driver.positionText)
                            .foregroundColor(.white)
                            .font(.custom("Noto Sans", size: 32))
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Pts")
                            .foregroundColor(.white.opacity(0.7))
                        Text("\(driver.points)")
                            .foregroundColor(.white)
                            .font(.custom("Noto Sans", size: 32))
                            .bold()
                    }
                    .padding(.leading, 24)

                    Spacer()

                    Image(systemName: "bolt.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 60)
                        .foregroundColor(.white.opacity(0.9))
                }
            }
            .padding()
        }
        .frame(height: 200)
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private var progressView: some View {
        IndeterminateProgressView()
            .foregroundStyle(ThemeManager.shared.selectedTeamColor)
            .transition(.opacity)
    }
}

#Preview {
    HomeView()
}
