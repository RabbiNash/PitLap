//
//  GameView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI
import SafariServices

struct TriviaView: View {
    @State private var showSettings: Bool = false
    @State private var showWebView: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerView
                    contentCards
                    analysisCards
                    starLightsCard
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            settingsView
        }
        .fullScreenCover(isPresented: $showWebView) {
            safariView
        }
    }

    var headerView: some View {
        HStack {
            Text("Trivia")
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

    var analysisCards: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                NavigationLink(destination: DriverAnalysisView()) {
                    TriviaCard(
                        level: "Analysis",
                        icon: "flag.checkered",
                        iconColor: ThemeManager.shared.selectedTeamColor,
                        title: "Who still has a chance?",
                        subtitle: "Find out if your favorite driver can still win the championship",
                        progressColor: ThemeManager.shared.selectedTeamColor
                    )
                }.buttonStyle(.plain)

                TriviaCard(
                    level: "Analysis",
                    icon: "chart.line.uptrend.xyaxis",
                    iconColor: ThemeManager.shared.selectedTeamColor,
                    title: "Play with telemetry data",
                    subtitle: "Do you fancy playing with telemetry data, creating lap charts etc? F1 Tempo can help",
                    progressColor: ThemeManager.shared.selectedTeamColor
                ).onTapGesture {
                    showWebView = true
                }
            }
            .padding(.horizontal)
        }
    }

    var starLightsCard: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                NavigationLink(destination: StarLightsView()) {
                    TriviaCard(
                        level: "Analysis",
                        icon: "chart.line.uptrend.xyaxis",
                        iconColor: ThemeManager.shared.selectedTeamColor,
                        title: "StarLights",
                        subtitle: "Do you fancy experiencing Formula 1 in Your Menu Bar? Click to explore star lights",
                        progressColor: ThemeManager.shared.selectedTeamColor
                    )
                }.buttonStyle(.plain)
            }
            .padding(.horizontal)
        }
    }
    
    var contentCards: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                NavigationLink(destination: VideoListView()) {
                    TriviaCard(
                        level: "News",
                        icon: "video",
                        iconColor: ThemeManager.shared.selectedTeamColor,
                        title: "Videos",
                        subtitle: "Keep in touch with all your favourite Youtube Video creators, get all the news and analysis here",
                        progressColor: ThemeManager.shared.selectedTeamColor
                    )
                }.buttonStyle(.plain)
                
                NavigationLink(destination: RaceReactionView()) {
                    TriviaCard(
                        level: "Game",
                        icon: "flag.checkered",
                        iconColor: ThemeManager.shared.selectedTeamColor,
                        title: "Be an F1 Driver",
                        subtitle: "How quick are your reactions? Do you think you can beat the fastest F1 reaction time by Valterri Bottas of 0.04s",
                        progressColor: ThemeManager.shared.selectedTeamColor
                    )
                }.buttonStyle(.plain)
            }
            .padding(.horizontal)
        }
    }


    var settingsView: some View {
        SettingsView()
            .presentationDetents([.fraction(0.9)])
            .presentationBackgroundInteraction(.enabled)
    }

    var safariView: some View {
        SafariView(url: URL(string: "https://f1-tempo.com")!) {
            showWebView = false
        }
    }
}

struct TriviaCard: View {
    let level: String
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let progressColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(level)
                .font(.custom("Noto Sans", size: 12))
                .foregroundColor(.gray)

            Image(systemName: icon)
                .font(.custom("Noto Sans", size: 18))
                .foregroundColor(iconColor)
                .padding(12)
                .background(iconColor.opacity(0.1))
                .clipShape(Circle())

            Text(title)
                .font(.custom("Noto Sans", size: 16))
                .fontWeight(.semibold)

            Text(subtitle)
                .font(.custom("Noto Sans", size: 14))
                .foregroundColor(.gray)

            Rectangle()
                .frame(height: 4)
                .foregroundColor(progressColor)
                .cornerRadius(2)
        }
        .padding()
        .frame(width: 180)
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

struct ProgressCircle: View {
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(ThemeManager.shared.selectedTeamColor, lineWidth: 8)
            .rotationEffect(.degrees(-90))
    }
}


#Preview {
    TriviaView()
}
