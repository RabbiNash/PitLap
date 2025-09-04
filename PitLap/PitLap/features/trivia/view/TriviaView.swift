//
//  GameView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI
import SafariServices

struct TriviaView: View {
    @State private var showSettings = false
    @State private var showWebView = false

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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    cardSection(items: contentCards)
                    cardSection(items: starLightsCards)
                    cardSection(items: analysisCards)
                }
                .padding(.bottom, 32)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .presentationDetents([.fraction(0.9)])
                    .presentationBackgroundInteraction(.enabled)
            }
            .fullScreenCover(isPresented: $showWebView) {
                SafariView(url: URL(string: "https://f1-tempo.com")!) {
                    showWebView = false
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }

    private var header: some View {
        HStack {
            Text(LocalizedStrings.triviaTitle)
                .font(.largeTitle)
                .fontWeight(.bold)

            Spacer()

            Image(systemName: "gear.circle.fill")
                .resizable()
                .foregroundStyle(ThemeManager.shared.selectedTeamColor)
                .frame(width: 32, height: 32)
                .onTapGesture {
                    showSettings = true
                }
        }
        .padding(.horizontal)
    }

    private func cardSection(items: [TriviaCardItem]) -> some View {
        HorizontalCardScroll {
            ForEach(items) { item in
                if let destination = item.destination {
                    NavigationLink(destination: destination) {
                        makeTriviaCard(from: item)
                    }.buttonStyle(.plain)
                } else {
                    makeTriviaCard(from: item)
                        .onTapGesture {
                            item.action?()
                        }
                }
            }
        }
    }

    private var contentCards: [TriviaCardItem] {
            [
                .init(
                    level: "News",
                    icon: "video",
                    title: "Videos",
                    subtitle: "Keep in touch with all your favourite YouTube video creators. Get all the news and analysis here.",
                    destination: AnyView(VideoListView())
                ),
                .init(
                    level: "Game",
                    icon: "flag.checkered",
                    title: "Be an F1 Driver",
                    subtitle: "How quick are your reactions? Do you think you can beat the fastest F1 reaction time by Valtteri Bottas of 0.04s?",
                    destination: AnyView(RaceReactionView())
                )
            ]
        }

        private var analysisCards: [TriviaCardItem] {
            [    .init(
                    level: "Analysis",
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Play with telemetry data",
                    subtitle: "Do you fancy playing with telemetry data, creating lap charts, etc.? F1 Tempo can help.",
                    action: { showWebView = true }
                )
            ]
        }

        private var starLightsCards: [TriviaCardItem] {
            [
                .init(
                    level: "Analysis",
                    icon: "chart.line.uptrend.xyaxis",
                    title: "StarLights",
                    subtitle: "Do you fancy experiencing Formula 1 in your menu bar? Click to explore StarLights.",
                    destination: AnyView(StarLightsView())
                ),
                .init(
                    level: "Analysis",
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Check FIA Documents",
                    subtitle: "Are you curious about something, maybe a penalty applied by the FIA or official race classifications? Be sure to check FIA documents here.",
                    destination: AnyView(
                        SafariView(
                            url: URL(string: "https://www.fia.com/documents/championships/fia-formula-one-world-championship-14/season/season-2025-2071")!
                        )
                    )
                )
            ]
        }

    private func makeTriviaCard(from item: TriviaCardItem) -> some View {
        TriviaCard(
            level: item.level,
            icon: item.icon,
            iconColor: ThemeManager.shared.selectedTeamColor,
            title: item.title,
            subtitle: item.subtitle,
            progressColor: ThemeManager.shared.selectedTeamColor
        )
    }
}

struct TriviaCardItem: Identifiable {
    let id = UUID()
    let level: String
    let icon: String
    let title: String
    let subtitle: String
    let destination: AnyView?
    let action: (() -> Void)?

    init(level: String, icon: String, title: String, subtitle: String, destination: AnyView? = nil, action: (() -> Void)? = nil) {
        self.level = level
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.destination = destination
        self.action = action
    }
}

private struct HorizontalCardScroll<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                content
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TriviaView()
}
