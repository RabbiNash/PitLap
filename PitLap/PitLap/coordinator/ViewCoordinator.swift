//
//  ViewCoordinator.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 20/01/2025.
//

import SwiftUI
import PersistenceManager

struct ViewCoordinator: View {
    @StateObject private var viewModel = SplashViewModel(dataLogic: SeasonDataLogic(persistenceDataManager: .shared()))

    @AppStorage("selectedTeam") private var selectedTeam: String = F1Team.redBull.rawValue

    @State private var themeKey = UUID()

    var body: some View {
        Group {
            if viewModel.isDataLoaded {
                ContentView()
            } else {
                SplashView()
            }
        }
        .id(themeKey)
        .onChange(of: selectedTeam, { _, _ in
            themeKey = UUID()
        })
        .task {
            await viewModel.checkDataLoaded()
        }
    }
}


#Preview {
    ViewCoordinator()
}
