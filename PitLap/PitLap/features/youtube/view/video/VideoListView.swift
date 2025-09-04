//
//  VideoListView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 22/02/2025.
//

import SwiftUI

struct VideoListView: View {
    @StateObject var viewModel: YoutubeViewModel
    
    init(viewModel: YoutubeViewModel = .init()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [ThemeManager.shared.selectedTeamColor.opacity(0.5), Color.clear]),
                        startPoint: .top,
                        endPoint: .center
                    )
                )
                .ignoresSafeArea(.all)
                .shadow(radius: 8)
            
            ScrollView {
                LazyVStack {
                    HStack {
                        Picker(selection: $viewModel.selectedChannel, label: Text("Select Preferred Channel")) {
                            ForEach(F1YoutubeChannels.allCases, id: \.self) { channel in
                                Text(channel.rawValue)
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                    ForEach(viewModel.videos, id: \.videoId) { video in
                        NavigationLink(destination: VideoPlayerDescriptionView(video: video)) {
                            VideoItem(video: video)
                                .transition(.opacity.combined(with: .move(edge: .leading)))
                        }.buttonStyle(.plain)
                    }
                }
                .animation(.smooth, value: viewModel.videos)
                .padding(.horizontal)
                .overlay(progressView, alignment: .top)
            }.refreshable {
                viewModel.fetchVideos(title: viewModel.selectedChannel.rawValue, forceRefresh: true)
            }
            .onChange(of: viewModel.selectedChannel, { _ , channel in
                withAnimation {
                    viewModel.fetchVideos(title: channel.rawValue)
                }
            })
            .onAppear {
                viewModel.fetchVideos(title: viewModel.selectedChannel.rawValue)
            }
        }
    }
    
    @ViewBuilder private var progressView: some View {
        if viewModel.isLoading {
            IndeterminateProgressView()
                .foregroundStyle(ThemeManager.shared.selectedTeamColor)
                .transition(.opacity)
        }
    }
}
