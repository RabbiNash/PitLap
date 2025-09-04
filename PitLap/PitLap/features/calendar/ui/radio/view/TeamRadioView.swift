//
//  QualiResultView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import SwiftUI
import PitlapKit
import SwiftfulRouting

struct TeamRadioView: View {
    @StateObject var viewModel: RadioViewModel = RadioViewModel()
    
    private let raceResult: RaceResultModel
    private let router: AnyRouter
    
    init(raceResult: RaceResultModel, router: AnyRouter) {
        self.raceResult = raceResult
        self.router = router
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [ThemeManager.shared.selectedTeamColor.opacity(0.5), Color.clear]),
                        startPoint: .top,
                        endPoint: .center
                    )
                )
                .ignoresSafeArea(.all)
                .shadow(radius: 8)
            
            content
                
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Team Radios")
            .onAppear {
                Task {
                    await viewModel.fetchLatestRadios(driverNumber: getDriverNumber(fullName: raceResult.fullName) ?? 1)
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
        ForEach(viewModel.radios, id: \.date) { row in
            RadioRow(rowModel: row, raceResultModel: raceResult)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(ThemeManager.shared.selectedTeamColor)
                )
                .onTapGesture {
                    let destination = AnyDestination(
                        segue: .push,
                        destination: { router in
                            AudioPlaybackView(audioUrl: row.recordingUrl)
                        }
                    )
                    
                    router.showScreen(destination)
                }
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
    
    let drivers: [String: Int] = [
        // Red Bull
        "Max Verstappen": 1,
        "Yuki Tsunoda": 22,

        // Ferrari
        "Lewis Hamilton": 44,
        "Charles Leclerc": 16,

        // Mercedes
        "George Russell": 63,
        "Andrea Kimi Antonelli": 12,

        // McLaren
        "Lando Norris": 4,
        "Oscar Piastri": 81,

        // Aston Martin
        "Fernando Alonso": 14,
        "Lance Stroll": 18,

        // Alpine
        "Pierre Gasly": 10,
        "Franco Colapinto": 43,

        // Haas
        "Esteban Ocon": 31,
        "Oliver Bearman": 87,

        // Racing Bulls
        "Liam Lawson": 30,
        "Isack Hadjar": 6,

        // Sauber (Audi)
        "Nico Hulkenberg": 27,
        "Gabriel Bortoleto": 5,

        // Williams
        "Carlos Sainz": 55,
        "Alex Albon": 23
    ]
    
    func getDriverNumber(fullName: String) -> Int? {
        return drivers[fullName]
    }

}
