//
//  DriverStandingsView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI

struct StandingsView: View {
    @StateObject private var viewModel: StandingsViewModel
    @State private var selectedTab: StandingOption = .drivers

    init(dataLogic: StandingsDataLogic = StandingsDataLogic()) {
        _viewModel = StateObject(wrappedValue: StandingsViewModel(dataLogic: dataLogic))
    }

    var body: some View {
        NavigationStack {
            content
                .padding(24)
        }
    }

    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                StandingPickerView(selectedOption: $selectedTab, options: StandingOption.allCases)
                standingsList
            }
            .overlay(progressView, alignment: .top)
        }
        .refreshable {
            fetchStandings(for: selectedTab, forceRefresh: true)
        }
        .onChange(of: selectedTab) { _, newValue in fetchStandings(for: newValue) }
        .task {
            fetchStandings(for: selectedTab)
        }
    }

    private var standingsList: some View {
        ForEach(viewModel.standings, id: \.id) { standingRow in
            StandingRow(rowModel: standingRow)
        }
    }

    @ViewBuilder private var progressView: some View {
        if viewModel.isLoading {
            IndeterminateProgressView()
                .foregroundStyle(ThemeManager.shared.selectedTeamColor)
        }
    }

    private func fetchStandings(for option: StandingOption, forceRefresh: Bool = false) {
        Task { @MainActor in
            switch option {
            case .constructors:
                await viewModel.getConstructorStandings(forceRefresh: forceRefresh)
            case .drivers:
                await viewModel.getDriverStandings(forceRefresh: forceRefresh)
            }
        }
    }
}
