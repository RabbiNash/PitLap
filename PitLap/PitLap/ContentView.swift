//
//  ContentView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var activeTab: BottomNavTab = .seasons
    @State private var isTabBarHidden: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                TabView(selection: $activeTab) {
                    SeasonView()
                        .tag(BottomNavTab.seasons)
                        .background {
                            if !isTabBarHidden {
                                HideTabBar {
                                    isTabBarHidden = true
                                }
                            }
                        }

                    StandingsView()
                        .tag(BottomNavTab.standings)

                    ArticleFeedView()
                        .tag(BottomNavTab.news)

                    TriviaView()
                        .tag(BottomNavTab.trivia)
                }
            }

            BottomNavTabBar(activeTab: $activeTab)
        }
    }
}

#Preview {
    ContentView()
}
