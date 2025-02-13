//
//  QualiResultView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import SwiftUI

struct QualiResultView: View {
    @StateObject var viewModel: QualiViewModel
    
    private let year: Int
    private let round: Int
    
    init(viewModel: QualiViewModel = QualiViewModel(), year: Int, round: Int) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.year = year
        self.round = round
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Quali Result")
                .onAppear {
                    Task {
                        viewModel.viewDidAppear(year: year, round: round)
                    }
                }
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
        ForEach(viewModel.results, id: \.position) { row in
            QualiResultRow(rowModel: row)
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
