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
        }
    }

    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                StandingPickerView(selectedOption: $selectedTab, options: StandingOption.allCases)
                standingsList
            }
            .padding(24)
            .overlay(progressView, alignment: .top)
        }
        .onChange(of: selectedTab) { _, newValue in fetchStandings(for: newValue) }
        .onAppear {
            Task { @MainActor in
                await viewModel.getDriverStandings()
            }
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

    private func fetchStandings(for option: StandingOption) {
        Task { @MainActor in
            switch option {
            case .constructors:
                await viewModel.getConstructorStandings()
            case .drivers:
                await viewModel.getDriverStandings()
            }
        }
    }
}
