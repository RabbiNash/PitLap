//
//  ArticleFeedView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 31/01/2025.
//

import SwiftUI
import Kingfisher

struct ArticleFeedView: View {
    @StateObject private var viewModel = ArticleFeedViewModel()

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                IndeterminateProgressView()
            case .error:
                Text("Failed to load feed")
            case .success:
                ScrollView {
                    TabView {
                        ForEach(viewModel.feedChannel?.items ?? [], id: \.guid) { item in
                            ArticleView(feed: item)
                        }
                    }.frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    ).tabViewStyle(.page)
                }
                .overlay(progressView, alignment: .top)
                .edgesIgnoringSafeArea(.all)
            }
        }.onAppear {
            Task {
                await viewModel.getFeed(from: .autosport)
            }
        }
    }

    @ViewBuilder private var progressView: some View {
        if viewModel.isLoading {
            IndeterminateProgressView()
                .foregroundStyle(ThemeManager.shared.selectedTeamColor)
        }
    }
}

#Preview {
    ArticleFeedView()
}
