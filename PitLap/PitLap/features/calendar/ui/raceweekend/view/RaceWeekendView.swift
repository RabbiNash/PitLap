//
//  RaceWeekendView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PitlapKit

struct RaceWeekendView: View {
    private let event: EventScheduleModel
    
    @StateObject private var viewModel: RaceWeekendViewModel
    @Namespace private var namespace
    
    @State var activeSheet: SessionType?
    @State var showSheet: Bool = false

    init(event: EventScheduleModel, viewModel: RaceWeekendViewModel = RaceWeekendViewModel()) {
        self.event = event
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    RaceWeekendHeaderView(event: event)
                    if !isPastEvent(sessionTime: event.session5DateUTC ?? "") {
                        HStack {
                            Spacer()
                            NavigationLink(destination: SessionWeatherView(round: Int(event.round), year: Int(event.year) ?? 0)) {
                                Text("Session Weather")
                                    .foregroundStyle(ThemeManager.shared.selectedTeamColor)
                            }.buttonStyle(.plain)
                        }
                    }
                    eventNameView
                    sessionTimesView
                    
                    Group {
                        raceSummaryView
                        trackFactsView
                        Spacer()
                    }.padding(.bottom, 24)
                }
                .sheet(item: $activeSheet) { sessionType in
                    sheetContent(for: sessionType)
                        .presentationBackgroundInteraction(.disabled)
                        .presentationDetents([.medium, .large])
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
                    SessionItemView(sessionName: event.sessionName(for: sessionType), sessionTime: sessionTime)
                        .onTapGesture {
                            if isPastEvent(sessionTime: event.session1DateUTC ?? "") {
                                activeSheet = sessionType
                            }
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
    private func sheetContent(for sessionType: SessionType) -> some View {
        if let year = Int(event.year) {
            let round = event.round
            
            switch sessionType {
            case .session5:
                RaceResultView(year: year, round: Int(round))
            case .session4:
                QualifyingResultView(year: year, round: Int(round))
            case .session1:
                PracticeView(year: year, round: Int(round), sessionName: event.session1)
            case .session2 where event.session2 == "Practice 2",
                 .session3 where event.session3 == "Practice 3":
                PracticeView(year: year, round: Int(round), sessionName: sessionType == .session2 ? event.session2 : event.session3)
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

enum SessionType: String, CaseIterable, Identifiable {
    case session1, session2, session3, session4, session5
    
    var id: Int {
        hashValue
    }
}

extension EventScheduleModel {
    func sessionTime(for type: SessionType) -> String? {
        switch type {
        case .session1: return session1DateUTC
        case .session2: return session2DateUTC
        case .session3: return session3DateUTC
        case .session4: return session4DateUTC
        case .session5: return session5DateUTC
        }
    }
    
    func sessionName(for type: SessionType) -> String {
        switch type {
        case .session1: return session1
        case .session2: return session2
        case .session3: return session3
        case .session4: return session4
        case .session5: return session5
        }
    }
}
