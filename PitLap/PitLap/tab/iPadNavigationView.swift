//
//  iPadNavigationView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI

struct iPadNavigationView: View {
    @Binding var activeTab: BottomNavTab
    @State private var isSidebarVisible: Bool = true
    
    var body: some View {
        NavigationSplitView {
            // Sidebar
            VStack(alignment: .leading, spacing: 0) {
                // App Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "car.fill")
                            .font(.title2)
                            .foregroundColor(ThemeManager.shared.selectedTeamColor)
                        
                        Text("PitLap")
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    Text("F1 Racing Companion")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }
                .background(Color(.systemBackground))
                
                Divider()
                
                // Navigation Items
                VStack(spacing: 4) {
                    ForEach(BottomNavTab.allCases, id: \.self) { tab in
                        iPadNavigationItem(
                            tab: tab,
                            isSelected: activeTab == tab,
                            action: { activeTab = tab }
                        )
                    }
                }
                .padding(.vertical, 8)
                
                Spacer()
                
                // Settings or additional info
                VStack {
                    Divider()
                    HStack {
                        Image(systemName: "gear")
                            .font(.caption)
                        Text("Settings")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                }
            }
            .background(Color(.systemBackground))
            .navigationSplitViewColumnWidth(min: 200, ideal: 250, max: 300)
        } detail: {
            // Main Content
            Group {
                switch activeTab {
                case .home:
                    HomeView()
                case .seasons:
                    RaceCalendarView()
                case .standings:
                    StandingsView()
                case .trivia:
                    TriviaView()
                case .insights:
                    TriviaView()
                }
            }
            .navigationTitle(activeTab.title)
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationSplitViewStyle(.balanced)
    }
}

struct iPadNavigationItem: View {
    let tab: BottomNavTab
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: tab.icon)
                    .font(.title3)
                    .frame(width: 24, height: 24)
                    .foregroundColor(isSelected ? .white : .primary)
                
                Text(tab.title)
                    .font(.body)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(isSelected ? .white : .primary)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? ThemeManager.shared.selectedTeamColor : Color.clear)
            )
            .padding(.horizontal, 12)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Compact Navigation for smaller iPads or iPhone
struct CompactNavigationView: View {
    @Binding var activeTab: BottomNavTab
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Content
            Group {
                switch activeTab {
                case .home:
                    HomeView()
                case .seasons:
                    RaceCalendarView()
                case .standings:
                    StandingsView()
                case .trivia:
                    TriviaView()
                case .insights:
                    TriviaView()
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Bottom Tab Bar
            BottomNavTabBar(activeTab: $activeTab)
        }
    }
}

#Preview {
    iPadNavigationView(activeTab: .constant(.home))
}
