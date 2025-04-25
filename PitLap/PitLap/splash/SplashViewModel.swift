//
//  SplashViewModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 20/01/2025.
//

import Foundation

@MainActor
final class SplashViewModel: ObservableObject {
    private let dataLogic: RaceCalendarDataLogicType
    @Published var isDataLoaded: Bool = false

    init(dataLogic: RaceCalendarDataLogicType = RaceCalendarDataLogic()) {
        self.dataLogic = dataLogic
    }

    func checkDataLoaded() async {
        if await dataLogic.isDataLoaded() {
            isDataLoaded = true
            return
        }
        
        let currentYear = Calendar.current.component(.year, from: Date())
        let calendar = await dataLogic.getRaceCalendar(for: currentYear, forceRefresh: false)
        isDataLoaded = !calendar.isEmpty
    }
}
