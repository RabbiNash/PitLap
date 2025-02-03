//
//  DriverAnalysisView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI

struct DriverAnalysisView: View {
    @StateObject private var viewModel = DriverAnalysisViewModel(dataLogic: DriverAnalysisDataLogic())

    var body: some View {
        List(viewModel.driverAnalysis, id: \ .position) { driver in
            VStack(alignment: .leading, spacing: 8) {
                Text("\(driver.position). \(driver.name)")
                    .font(.headline)

                HStack {
                    Text("Current Points: \(driver.currentPoints)")
                    Spacer()
                    Text("Max Points: \(driver.theoreticalMaxPoints)")
                }
                .font(.subheadline)
                .foregroundColor(.gray)

                Text("Can Win: \(driver.canWin)")
                    .font(.footnote)
                    .foregroundColor(driver.canWin == "Yes" ? .green : .red)
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("Driver Analysis")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getDriverStandings()
        }
    }
}

#Preview {
    DriverAnalysisView()
}
