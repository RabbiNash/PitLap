//
//  SessionTopSpeedView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 16/05/2025.
//

import SwiftUI
import Charts

struct SessionTopSpeedView: View {
    
    @StateObject private var viewModel: SessionTopSpeedViewModel = .init()
    
    private let year: Int
    private var round: Int
    private let sessionName: String
    
    init(
        year: Int,
        round: Int,
        sessionName: String
    ) {
        self.year = year
        self.round = round
        self.sessionName = sessionName
    }
    
    var body: some View {
        VStack {
            switch viewModel.fetchStatus {
            case .fetching:
                IndeterminateProgressView()
            case .success:
                chart
            case .failed(let message):
                Text("No data available \(message)")
                    .styleAsBodyLarge()
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 42)
        .padding(.top)
        .task {
            await viewModel.fetchTopSpeeds(year: year, round: round, sessionName: sessionName)
        }
    }
    
    @ViewBuilder
    var chart: some View {
        Chart(viewModel.topSpeeds, id: \.driver) { data in
            BarMark(x: .value("Speed", data.speed),
                    y: .value("Driver", data.driver))
            .annotation(position: .trailing, alignment: .leading, content: {
                Text(String(data.speed))
            })
            .foregroundStyle(F1Team.color(for: data.driver))
        }
        .chartLegend(.hidden)
        .frame(maxHeight: 800)
    }
}
