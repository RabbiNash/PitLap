//
//  SeasonCalendarView.swift
//  Pitlap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import WidgetKit

struct RaceCalendarView: View {
    @StateObject private var viewModel: RaceCalendarViewModel
    @State private var showOldRacesSheet: Bool = false
    
    init(viewModel: RaceCalendarViewModel = RaceCalendarViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

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
                    if let event = viewModel.nextSession {
                        NavigationLink(destination: RaceWeekendView(event: event)) {
                            RaceWeekendHeaderView(event: event)
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
                        viewModel.loadSeasonCalendar(year: viewModel.currentYear)
                    }
            }.sheet(isPresented: $showOldRacesSheet) {
                OldRacesView()
                    .presentationDetents([.fraction(0.7), .large])
                    .presentationBackgroundInteraction(.disabled)
            }
        }
        .refreshable {
            viewModel.refresh(forceRefresh: true)
        }
        .padding(24)
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

#Preview {
    RaceCalendarView()
}

