//
//  OldRacesView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 19/03/2025.
//

import SwiftUI

struct OldRacesView: View {
    @State var selectedTab: SeasonTabOption = .first
    @StateObject private var viewModel = SeasonViewModel(dataLogic: SeasonDataLogic(persistenceDataManager: .shared()))

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    SeasonPicker(selectedOption: $selectedTab)
                        .padding()
                    
                    Group {
                        switch selectedTab {
                        case .first:
                            seasonView
                                .onAppear {
                                    viewModel.loadSeasonCalendar(year: "2025", showPastEvents: true)
                                }
                        case .second:
                            seasonView
                                .onAppear {
                                    viewModel.loadSeasonCalendar(year: "2024", showPastEvents: true)
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
            ForEach(viewModel.seasonCalendar, id: \.self) { raceWeekend in
                NavigationLink(destination: RaceWeekendView(weekend: raceWeekend)) {
                    RaceWeekendListItemView(weekend: raceWeekend)
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}
