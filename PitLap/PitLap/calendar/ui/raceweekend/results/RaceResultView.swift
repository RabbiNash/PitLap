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
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(ThemeManager.shared.selectedTeamColor)
                )
                .frame(height: 100)
                .visualEffect { content, proxy in
                    let frame = proxy.frame(in: .scrollView(axis: .vertical))

                    let distance = min(0, frame.minY)

                    return content
                        .hueRotation(.degrees(frame.origin.y / 10))
                        .scaleEffect(1 + distance / 700)
                        .offset(y: -distance / 1.25)
                        .brightness(-distance / 400)
                        .blur(radius: -distance / 50)
                }
        }
    }
}
