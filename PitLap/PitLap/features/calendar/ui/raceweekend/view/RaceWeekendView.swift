//
//  RaceWeekendView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PitlapKit
import SwiftfulRouting

struct RaceWeekendView: View {
    private let event: EventScheduleModel
    private let router: AnyRouter
    
    @StateObject private var viewModel: RaceWeekendViewModel
    @Namespace private var namespace
    
    @State var activeSheet: SessionType?
    @State var showSheet: Bool = false

    init(event: EventScheduleModel, viewModel: RaceWeekendViewModel = RaceWeekendViewModel(), router: AnyRouter) {
        self.event = event
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
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    RaceWeekendHeaderView(event: event)
                    if !isPastEvent(sessionTime: event.session5DateUTC ?? "") {
                        HStack {
                            Spacer()
                            Text("Session Weather")
                                .foregroundStyle(ThemeManager.shared.selectedTeamColor)
                                .onTapGesture {
                                    let destination = AnyDestination(
                                        segue: .push,
                                        destination: { router in
                                            SessionWeatherView(round: Int(event.round), year: Int(event.year) ?? 0)
                                        }
                                    )
                                    
                                    router.showScreen(destination)
                                }
                        }
                    }
                    eventNameView
                    sessionTimesView
                    sessionWeather
                    
                    Group {
                        raceSummaryView
                        trackFactsView
                        Spacer()
                    }.padding(.bottom, 24)
                }
                .padding(24)
                .overlay(progressView, alignment: .top)
            }
        }
        .onAppear(perform: loadData)
    }

    private var eventNameView: some View {
        Text(event.eventName)
            .font(.custom("Audiowide", size: 24))
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
            .padding(.vertical, 8)
            .foregroundColor(.primary)
            .background(
                ThemeManager.shared.selectedTeamColor
                    .frame(height: 6)
                    .offset(y: 24)
            )
    }

    private var sessionTimesView: some View {
        ForEach(SessionType.allCases, id: \.self) { sessionType in
            if let sessionTime = event.sessionTime(for: sessionType) {
                if event.sessionName(for: sessionType) != "None" {
                    if isPastEvent(sessionTime: event.sessionTime(for: sessionType) ?? "") {
                        SessionItemView(sessionName: event.sessionName(for: sessionType), sessionTime: sessionTime)
                            .onTapGesture {
                                let destination = AnyDestination(
                                    segue: .push,
                                    destination: { router in
                                        sheetContent(for: sessionType, router: router)
                                    }
                                )
                                
                                router.showScreen(destination)
                            }
                    } else {
                        SessionItemView(sessionName: event.sessionName(for: sessionType), sessionTime: sessionTime)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var raceSummaryView: some View {
        if let raceSummary = viewModel.raceSummary {
            SummaryView(title: "Race Summary", content: raceSummary.summary)
        }
    }

    @ViewBuilder
    private var trackFactsView: some View {
        if let trackSummary = viewModel.trackSummary {
            SummaryView(title: "Track Facts", content: trackSummary.fact)
        }
    }

    @ViewBuilder
    private var progressView: some View {
        if viewModel.isLoading {
            IndeterminateProgressView()
                .foregroundStyle(ThemeManager.shared.selectedTeamColor)
        }
    }
    
    @ViewBuilder
    private var sessionWeather: some View {
        if let weather = viewModel.weather {
            VStack(alignment: .leading) {
                Text("Race Day Weather")
                    .font(.custom("Audiowide", size: 24))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 8)
                    .foregroundColor(.primary)
                    .background(
                        ThemeManager.shared.selectedTeamColor
                            .frame(height: 6)
                            .offset(y: 24)
                    )
                
                WeatherEntryCard(weather: weather, event: event)
            }
        }
    }
    
    @ViewBuilder
    private func sheetContent(for sessionType: SessionType, router: AnyRouter) -> some View {
        if let year = Int(event.year) {
            let round = event.round
            
            switch sessionType {
            case .session5:
                RaceResultView(year: year, round: Int(round), router: router)
            case .session4:
                QualifyingResultView(year: year, round: Int(round))
            case .session1:
                PracticeView(year: year, round: Int(round), sessionName: event.session1, router: router)
            case .session2 where event.session2 == "Practice 2",
                 .session3 where event.session3 == "Practice 3":
                PracticeView(year: year, round: Int(round), sessionName: sessionType == .session2 ? event.session2 : event.session3, router: router)
            default:
                Text("Coming Soon")
            }
        } else {
            Text("Invalid Year")
        }
    }

    private func loadData() {
        let currentYear = Calendar.current.component(.year, from: Date())
        viewModel.viewDidAppear(round: Int(event.round), year: Int(event.year) ?? currentYear, trackName: event.eventName)
    }
    
    private func isPastEvent(sessionTime: String) -> Bool {
        let currentDate = Date()
        return Date.getDateFromString(dateString: sessionTime) ?? Date() < currentDate
    }
}

struct SummaryView: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.custom("Audiowide", size: 24))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 8)
                .foregroundColor(.primary)
                .background(
                    ThemeManager.shared.selectedTeamColor
                        .frame(height: 6)
                        .offset(y: 24)
                )
            
            Text(content)
        }
    }
}

