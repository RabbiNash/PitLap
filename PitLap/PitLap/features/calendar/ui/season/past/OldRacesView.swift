//
//  OldRacesView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 19/03/2025.
//

import SwiftUI
import SwiftfulRouting

struct OldRacesView: View {
    @State var selectedTab: SeasonTabOption = .current
    @StateObject private var viewModel = RaceCalendarViewModel()
    
    private let router: AnyRouter
    
    init(viewModel: RaceCalendarViewModel = RaceCalendarViewModel(), router: AnyRouter) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.router = router
    }

    var body: some View {
        ZStack {
            Rectangle()
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
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    SeasonPicker(selectedOption: $selectedTab)
                        .padding()
                    
                    Group {
                        switch selectedTab {
                        case .current:
                            seasonView
                                .onAppear {
                                    viewModel.loadSeasonCalendar(year: viewModel.currentYear, showPastEvents: true)
                                }
                        case .previous:
                            seasonView
                                .onAppear {
                                    viewModel.loadSeasonCalendar(year: viewModel.currentYear - 1, showPastEvents: true)
                                }
                        }
                    }
                }
            }.padding(.horizontal, 24)
        }
        .navigationTitle("Race Calendar")
    }
    
    @ViewBuilder
    private var seasonView: some View {
        VStack {
            ForEach(viewModel.seasonCalendar, id: \.self) { event in
                RaceWeekendListItemView(event: event)
                    .onTapGesture {
                        let destination = AnyDestination(
                            segue: .push,
                            destination: { router in
                                RaceWeekendView(event: event, router: router)                                  }
                        )
                        
                        router.showScreen(destination)
                    }
            }
        }
    }
}
