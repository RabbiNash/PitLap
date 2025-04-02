//
//  RaceWeekendView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI
import PersistenceManager

struct RaceWeekendView: View {
    private let weekend: RaceWeekendEntity
    
    @StateObject private var viewModel: RaceWeekendViewModel
    @Namespace private var namespace
    
    @State var activeSheet: SessionType?
    @State var showSheet: Bool = false

    init(weekend: RaceWeekendEntity, viewModel: RaceWeekendViewModel = RaceWeekendViewModel()) {
        self.weekend = weekend
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    RaceWeekendHeaderView(weekend: weekend)
                    if !isPastEvent(sessionTime: weekend.session5DateUTC) {
                        HStack {
                            Spacer()
                            NavigationLink(destination: SessionWeatherView(round: weekend.round, year: Int(weekend.year) ?? 0)) {
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
        Text(weekend.eventName)
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
            if let sessionTime = weekend.sessionTime(for: sessionType) {
                if weekend.sessionName(for: sessionType) != "None" {
                    SessionItemView(sessionName: weekend.sessionName(for: sessionType), sessionTime: sessionTime)
                        .onTapGesture {
                            if isPastEvent(sessionTime: weekend.session1DateUTC) {
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
        if let year = Int(weekend.year) {
            let round = weekend.round
            
            switch sessionType {
            case .session5:
                RaceResultView(year: year, round: round)
            case .session4:
                QualiResultView(year: year, round: round)
            case .session1:
                PracticeView(year: year, round: round, sessionName: weekend.session1.rawValue)
            case .session2 where weekend.session2 == .practice2,
                 .session3 where weekend.session3 == .practice3:
                PracticeView(year: year, round: round, sessionName: sessionType == .session2 ? weekend.session2.rawValue : weekend.session3.rawValue)
            default:
                Text("Coming Soon")
            }
        } else {
            Text("Invalid Year")
        }
    }

    private func loadData() {
        viewModel.viewDidAppear(round: weekend.round, year: Int(weekend.year) ?? 2024, trackName: weekend.eventName)
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

extension RaceWeekendEntity {
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
        case .session1: return session1.rawValue
        case .session2: return session2.rawValue
        case .session3: return session3.rawValue
        case .session4: return session4.rawValue
        case .session5: return session5.rawValue
        }
    }
}
