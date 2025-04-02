//
//  ContentView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var activeTab: BottomNavTab = .seasons
    @State private var isTabBarHidden: Bool = false
    @StateObject private var viewModel: ViewModel = ViewModel()

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
                        }.sheet(isPresented: $viewModel.showOnboarding) {
                            OnboardingView()
                                .interactiveDismissDisabled()
                        }

                    StandingsView()
                        .tag(BottomNavTab.standings)

                    ArticleFeedView()
                        .tag(BottomNavTab.news)
                    
                    VideoListView()
                        .tag(BottomNavTab.videos)
                    
                    TriviaView()
                        .tag(BottomNavTab.trivia)
                }
            }

            BottomNavTabBar(activeTab: $activeTab)
        }
    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        
        @AppStorage("onboardingCompleted")
        private var onboardingCompleted: Bool = false
        
        @Published var showOnboarding: Bool = false
        
        init() {
            checkOnboardingStatus()
        }
        
        var shouldShowOnboarding: Bool {
            !onboardingCompleted
        }
        
        func checkOnboardingStatus() {
            showOnboarding = !onboardingCompleted
        }
           
    }
}

#Preview {
    ContentView()
}
