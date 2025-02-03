//
//  SplashViewModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 20/01/2025.
//

import Foundation

@MainActor
final class SplashViewModel: ObservableObject {
    private let dataLogic: SeasonDataLogicType
    @Published var isDataLoaded: Bool = false

    init(dataLogic: SeasonDataLogicType) {
        self.dataLogic = dataLogic
    }

    @MainActor
    func checkDataLoaded() async {
        isDataLoaded = await dataLogic.isDataLoaded()

        if !isDataLoaded {
            await dataLogic.loadSeasons { [weak self] isLoaded in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isDataLoaded = isLoaded
                }
            }
        }
    }
}
