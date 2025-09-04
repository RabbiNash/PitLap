//
//  iPadNavigationView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI

struct iPadNavigationView: View {
    @Binding var activeTab: BottomNavTab
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // Sidebar
            VStack(alignment: .leading, spacing: 0) {
                // App Header
                Text("Pitlap")
                    .styleAsDisplayHero()
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
        
                Divider()
                
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
                }
            }
        }
        .navigationSplitViewStyle(.balanced)
        .onAppear {
            // Ensure sidebar is visible on appear
            columnVisibility = .all
        }
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
