//
//  SeasonCalendarView.swift
//  Pitlap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import WidgetKit
import SwiftfulRouting

struct RaceCalendarView: View {
    @StateObject private var viewModel: RaceCalendarViewModel
    @State private var showOldRacesSheet: Bool = false
    @Environment(\.router) var router
    
    init(viewModel: RaceCalendarViewModel = RaceCalendarViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
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
                        RaceWeekendHeaderView(event: event)
                            .onTapGesture {
                                let destination = AnyDestination(
                                    segue: .push,
                                    destination: { router in
                                        RaceWeekendView(event: event, router: router)
                                    }
                                )
                                
                                router.showScreen(destination)
                            }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                HStack {
                    Text(LocalizedStrings.calendar)
                        .font(.custom("Audiowide",size: 28))
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    Text(LocalizedStrings.viewPastEvents)
                        .foregroundStyle(ThemeManager.shared.selectedTeamColor.gradient)
                        .onTapGesture {
                            let destination = AnyDestination(
                                segue: .push,
                                destination: { router in
                                    OldRacesView(router: router)
                                }
                            )
                            
                            router.showScreen(destination)
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
                OldRacesView(router: router)
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
                NavigationLink(destination: RaceWeekendView(event: event, router: router)) {
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

