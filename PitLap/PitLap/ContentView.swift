//
//  ContentView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import Observation
import SwiftfulRouting

struct ContentView: View {
    @State private var activeTab: BottomNavTab = .home
    @State private var isTabBarHidden: Bool = false
    @StateObject private var viewModel: ViewModel = ViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                TabView(selection: $activeTab) {
                    RouterView { _ in
                        HomeView()
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
                    }.tag(BottomNavTab.home)

                    
                    RouterView { _ in
                        RaceCalendarView()
                    }.tag(BottomNavTab.seasons)

                    

                    RouterView { _ in
                        StandingsView()
                    }.tag(BottomNavTab.standings)

                    
                    RouterView { _ in
                        TriviaView()
                    }.tag(BottomNavTab.trivia)
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
