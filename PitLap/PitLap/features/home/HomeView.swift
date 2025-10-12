//
//  HomeView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 03/04/2025.
//

import SwiftUI
import PitlapKit
import SwiftfulRouting

struct HomeView: View {
    @Environment(\.router) var router
    @Namespace private var namespace
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @State private var hasFetchedData = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    MeshGradient(width: 2, height: 2, points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 1], [0.5, 1], [1, 1]
                    ], colors: [ThemeManager.shared.selectedTeamColor.opacity(0.5), .clear, .clear,
                                .clear,ThemeManager.shared.selectedTeamColor.opacity(0.5), .clear])
                )
                .ignoresSafeArea(.all)
                .shadow(radius: 8)
            
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
            VStack(alignment: .leading, spacing: UIDevice.isIPad ? 32 : 24) {
                Text(LocalizedStrings.trendingNews)
                    .styleAsDisplaySmall()
                    .foregroundColor(.primary)
                    .background(
                        ThemeManager.shared.selectedTeamColor
                            .frame(height: 2)
                            .offset(y: 20)
                    )
                    .padding(.leading, UIDevice.isIPad ? 24 : 16)
                
                articleHorizontalList(router, feeds: viewModel.feed)
                
                Text(LocalizedStrings.latestVideos)
                    .font(.custom("Audiowide", size: UIDevice.isIPad ? 24 : 20))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .background(
                        ThemeManager.shared.selectedTeamColor
                            .frame(height: 2)
                            .offset(y: 20)
                    )
                    .padding(.leading, UIDevice.isIPad ? 24 : 16)
                
                // iPad-optimized grid layout
                if UIDevice.isIPad {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)) {
                        ForEach(viewModel.videos, id: \.videoId) { item in
                            NavigationLink(destination: VideoPlayerDescriptionView(video: item)) {
                                VideoItem(video: item)
                            }.buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 24)
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)) {
                        ForEach(viewModel.videos, id: \.videoId) { item in
                            NavigationLink(destination: VideoPlayerDescriptionView(video: item)) {
                                VideoItem(video: item)
                            }.buttonStyle(.plain)
                        }
                    }.padding(.horizontal)
                }
                
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
    func articleHorizontalList(_ router: AnyRouter, feeds: [RSSFeedItem]) -> some View {
        VStack(alignment: .center, spacing: UIDevice.isIPad ? 16 : 12) {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: UIDevice.isIPad ? 20 : 16) {
                    ForEach(feeds, id: \.id) { item in
                        ArticleFeedItemView(feed: item)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                let destination = AnyDestination(
                                    segue: .push,
                                    destination: { router in
                                        ArticleView(feed: item, router: router)
                                    }
                                )
                                
                                router.showScreen(destination)
                            }
                    }
                }
            }.contentMargins(.leading, UIDevice.isIPad ? 24 : 16)
        }
    }
    
//    @ViewBuilder
//    func articleHorizontalList(_ router: AnyRouter, feeds: [RSSFeedItem]) -> some View {
//        VStack(alignment: .center, spacing: UIDevice.isIPad ? 16 : 12) {
//            TabView {
//                ForEach(feeds, id: \.id) { item in
//                    ArticleFeedItemView(feed: item)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .padding(.horizontal, UIDevice.isIPad ? 24 : 16)
//                        .onTapGesture {
//                            let destination = AnyDestination(
//                                segue: .push,
//                                destination: { router in
//                                    ArticleView(feed: item, router: router)
//                                }
//                            )
//                            
//                            router.showScreen(destination)
//                        }
//                }
//            }
//            .tabViewStyle(.page(indexDisplayMode: .never))
//            .frame(height: UIDevice.isIPad ? 500 : 300)
//            .clipped()
//            .scrollIndicators(.hidden)
//        }
//    }
    
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
                        Text(LocalizedStrings.position)
                            .foregroundColor(.white.opacity(0.7))
                        Text(driver.positionText)
                            .foregroundColor(.white)
                            .font(.custom("Noto Sans", size: 32))
                            .bold()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(LocalizedStrings.points)
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
