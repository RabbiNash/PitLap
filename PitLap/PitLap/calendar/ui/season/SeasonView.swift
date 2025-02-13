//
//  SeasonCalendarView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import SwiftData
import WidgetKit

struct SeasonView: View {
    @StateObject private var viewModel = SeasonViewModel(dataLogic: SeasonDataLogic(persistenceDataManager: .shared()))

    @State var selectedTab: SeasonTabOption = .first

    var body: some View {
        NavigationStack {
            currentSeasonView
        }.onAppear {
            WidgetCenter.shared.reloadAllTimelines()
        }
    }

    @ViewBuilder
    private var currentSeasonView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                HStack {
                    if let raceWeekend = viewModel.nextSession {
                        NavigationLink(destination: RaceWeekendView(weekend: raceWeekend)) {
                            RaceWeekendHeaderView(weekend: raceWeekend)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                SeasonPicker(selectedOption: $selectedTab)
                    .padding()

                Text("Calendar")
                    .font(.custom("Audiowide",size: 28))
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)

                Divider()

                Group {
                    switch selectedTab {
                    case .first:
                        seasonView
                            .onAppear {
                                viewModel.loadSeasonCalendar(year: "2025")
                            }
                    case .second:
                        seasonView
                            .onAppear {
                                viewModel.loadSeasonCalendar(year: "2024")
                            }
                    }
                }
            }
        }
        .padding(16)
    }

    @ViewBuilder
    private var seasonView: some View {
        VStack {
            ForEach(viewModel.seasonCalendar.dropFirst(), id: \.self) { raceWeekend in
                NavigationLink(destination: RaceWeekendView(weekend: raceWeekend)) {
                    RaceWeekendListItemView(weekend: raceWeekend)
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    SeasonView()
}

struct SeasonPicker: View {
    @Binding var selectedOption: SeasonTabOption
    var options: [SeasonTabOption] = SeasonTabOption.allCases

    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    withAnimation {
                        selectedOption = option
                    }
                }) {
                    Text(option.title)
                        .font(.system(size: 14, weight: .medium))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedOption == option ? ThemeManager.shared.selectedTeamColor : Color.clear)
                        .foregroundColor(selectedOption == option ? .white : ThemeManager.shared.selectedTeamColor )
                        .overlay(
                            Capsule()
                                .stroke(ThemeManager.shared.selectedTeamColor, lineWidth: selectedOption == option ? 0 : 1)
                        )
                        .clipShape(Capsule())
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(4)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
