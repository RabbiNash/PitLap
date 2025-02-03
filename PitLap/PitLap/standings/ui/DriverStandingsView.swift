//
//  DriverStandingsView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI

struct DriverStandingsView: View {
    @StateObject var viewModel: DriverStandingsViewModel = .init(dataLogic: StandingsDataLogic())

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Standings")
                    .font(.custom("Formula1",size: 26))
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)

                List(viewModel.driverStandings, id: \.driverID) { driver in
                    DriverStandingRow(driver: driver)
                }
                .onAppear {
                    Task {
                        await viewModel.getDriverStandings()
                    }
                }
            }
        }
    }
}

struct DriverStandingRow: View {
    let driver: DriverStandingModel

    var body: some View {
        HStack {
            Text("\(driver.position)")
                .frame(width: 30)
                .font(.custom("Formula1",size: 16))


            VStack(alignment: .leading) {
                Text("\(driver.givenName) \(driver.familyName)")
                    .fontWeight(.bold)
                
                Text(driver.constructorNames.first ?? "")
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text("\(driver.points) pts")
                    .font(.headline)
                Text("\(driver.wins) wins")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
