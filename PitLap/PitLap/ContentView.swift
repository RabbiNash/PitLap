//
//  ContentView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var activeTab: BottomNavTab = .home
    @State private var isTabBarHidden: Bool = false
    @StateObject private var viewModel: ViewModel = ViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                TabView(selection: $activeTab) {
                    HomeView()
                        .tag(BottomNavTab.home)
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
                    
                    SeasonView()
                        .tag(BottomNavTab.seasons)
                    

                    StandingsView()
                        .tag(BottomNavTab.standings)
                    
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
