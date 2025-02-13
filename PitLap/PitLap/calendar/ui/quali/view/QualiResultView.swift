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
        }
    }
}
