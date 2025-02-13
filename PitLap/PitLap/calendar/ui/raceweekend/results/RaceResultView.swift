//
//  RaceResultView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import Foundation
import SwiftUI
import PersistenceManager

struct RaceResultView: View {
    private let results: [RaceResultEntity]
    
    init(results: [RaceResultEntity]) {
        self.results = results.sorted { $0.position < $1.position }
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Race Result")
        }
    }

    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                resultList
            }
            .padding(24)
        }
    }
    
    private var resultList: some View {
        ForEach(results, id: \.driver) { row in
            RaceResultRow(rowModel: row)
        }
    }
}
