//
//  GameView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI

struct TriviaView: View {

    @State private var showSettings: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Trivia")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Spacer()

                        Image(systemName: "gear.circle.fill")
                            .resizable()
                            .foregroundStyle(ThemeManager.shared.selectedTeamColor)                     .frame(width: 32, height: 32)
                            .onTapGesture {
                                showSettings = true
                            }
                    }
                    .padding(.horizontal)

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

                           

                        }
                        .padding(.horizontal)
                    }
                }.sheet(isPresented: $showSettings) {
                    SettingsView()
                }
            }
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
                .font(.custom("Titillium Web", size: 12))
                .foregroundColor(.gray)

            Image(systemName: icon)
                .font(.custom("Titillium Web", size: 18))
                .foregroundColor(iconColor)
                .padding(12)
                .background(iconColor.opacity(0.1))
                .clipShape(Circle())

            Text(title)
                .font(.custom("Titillium Web", size: 16))
                .fontWeight(.semibold)

            Text(subtitle)
                .font(.custom("Titillium Web", size: 14))
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
