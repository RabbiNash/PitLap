//
//  PracticeView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import SwiftUI
import SwiftfulRouting

struct PracticeView: View {
    @StateObject var viewModel: PracticeViewModel
    
    private let year: Int
    private let round: Int
    private let sessionName: String
    private let router: AnyRouter
    
    init(viewModel: PracticeViewModel = PracticeViewModel(),
         year: Int,
         round: Int,
         sessionName: String,
         router: AnyRouter
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.year = year
        self.round = round
        self.sessionName = sessionName
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(sessionName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    let destination = AnyDestination(
                        segue: .push,
                        destination: { router in
                            SessionTopSpeedView(year: year, round: round, sessionName: sessionName)
                        }
                    )
                    
                    router.showScreen(destination)
                }) {
                    Image(systemName: "speedometer")
                }
            }
        }
        .onAppear {
            Task {
                viewModel.viewDidAppear(year: year, round: round, sessionName: sessionName)
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
        ForEach(viewModel.results, id: \.driver) { row in
            NavigationLink(destination: LapTimesByCompoundView(groupedLapModel: row)) {
                PracticeResultRow(rowModel: row)
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
            }.buttonStyle(.plain)
        }
    }
}
