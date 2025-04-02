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

    @State private var showOldRacesSheet: Bool = false
    
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

                HStack {
                    Text("Calendar")
                        .font(.custom("Audiowide",size: 28))
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Text("View Past Events")
                        .foregroundStyle(ThemeManager.shared.selectedTeamColor.gradient)
                        .onTapGesture {
                            showOldRacesSheet = true
                        }
                }
                .frame(alignment: .center)
                .padding(.top)

                Divider()

                seasonView
                    .onAppear {
                        viewModel.loadSeasonCalendar(year: "2025")
                    }
            }.sheet(isPresented: $showOldRacesSheet) {
                OldRacesView()
                    .presentationDetents([.fraction(0.7), .large])
                    .presentationBackgroundInteraction(.disabled)
            }
        }
        .padding(24)
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
