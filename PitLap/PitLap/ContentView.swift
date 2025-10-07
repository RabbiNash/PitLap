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
    @StateObject private var viewModel = ViewModel()
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        Group {
            if UIDevice.isIPad && horizontalSizeClass == .regular {
                // iPad split view path (unchanged)
                iPadNavigationView(activeTab: $activeTab)
                    .sheet(isPresented: $viewModel.showOnboarding) {
                        OnboardingView()
                            .interactiveDismissDisabled()
                    }
            } else {
                // phone / compact iPad
                mainTabView
                    .sheet(isPresented: $viewModel.showOnboarding) {
                        OnboardingView()
                            .interactiveDismissDisabled()
                    }
            }
        }
    }
}

private extension ContentView {
    @ViewBuilder
    var mainTabView: some View {
        if #available(iOS 26, *) {
            TabView(selection: $activeTab) {
//                Tab("Home", systemImage: "house.fill", value: BottomNavTab.home) {
//                    RouterView { _ in HomeView() }
//                }

                Tab("Seasons", systemImage: "calendar", value: BottomNavTab.seasons) {
                    RouterView { _ in RaceCalendarView() }
                }

                Tab("Standings", systemImage: "list.number", value: BottomNavTab.standings) {
                    RouterView { _ in StandingsView() }
                }

                Tab("Trivia", systemImage: "lightbulb.fill", value: BottomNavTab.trivia) {
                    RouterView { _ in TriviaView() }
                }
                
                Tab("Search", systemImage: "magnifyingglass", value: BottomNavTab.insights, role: .search) {
                    RouterView { _ in
                        AnalysisView()
                    }
                }
            }
            .tabBarMinimizeBehavior(.onScrollDown)
        } else {
            // Fallback for earlier iOS: classic tabItem + tag
            TabView(selection: $activeTab) {
                RouterView { _ in HomeView() }
                    .tabItem { Label("Home", systemImage: "house.fill") }
                    .tag(BottomNavTab.home)

                RouterView { _ in RaceCalendarView() }
                    .tabItem { Label("Seasons", systemImage: "calendar") }
                    .tag(BottomNavTab.seasons)

                RouterView { _ in StandingsView() }
                    .tabItem { Label("Standings", systemImage: "list.number") }
                    .tag(BottomNavTab.standings)

                RouterView { _ in TriviaView() }
                    .tabItem { Label("Trivia", systemImage: "lightbulb.fill") }
                    .tag(BottomNavTab.trivia)
            }
        }
    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        @AppStorage("onboardingCompleted") private var onboardingCompleted = false
        @Published var showOnboarding = false

        init() {
            checkOnboardingStatus()
        }

        private func checkOnboardingStatus() {
            showOnboarding = !onboardingCompleted
        }

        // call this when onboarding finishes:
        func markOnboardingCompleted() {
            onboardingCompleted = true
            showOnboarding = false
        }
    }
}

#Preview {
    ContentView()
}
