//
//  PracticeViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation
import SwiftUI

final class PracticeViewModel: ObservableObject {
    private let dataLogic: LapsDataLogicType
    
    @Published var isLoading: Bool = false
    @Published var results: [GroupedLapModel] = []

    init(dataLogic: LapsDataLogicType = LapsDataLogic()) {
        self.dataLogic = dataLogic
    }

    func viewDidAppear(year: Int, round: Int, sessionName: String) {
        Task {
            await fetchPracticeLaps(year: year, round: round, sessionName: sessionName)
        }
    }
    
    @MainActor
    private func fetchPracticeLaps(year: Int, round: Int, sessionName: String) async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        results = await self.dataLogic.getLaps(year: year, round: round, sessionName: sessionName)
    }
}
