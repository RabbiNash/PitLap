//
//  OldRacesView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 19/03/2025.
//

import SwiftUI

struct OldRacesView: View {
    @State var selectedTab: SeasonTabOption = .current
    @StateObject private var viewModel = RaceCalendarViewModel()
    
    init(viewModel: RaceCalendarViewModel = RaceCalendarViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
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
            }.padding(24)
        }
    }
    
    @ViewBuilder
    private var seasonView: some View {
        VStack {
            ForEach(viewModel.seasonCalendar, id: \.self) { event in
                NavigationLink(destination: RaceWeekendView(event: event)) {
                    RaceWeekendListItemView(event: event)
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}
