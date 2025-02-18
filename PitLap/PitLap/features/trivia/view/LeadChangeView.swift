//
//  LeadChangeView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI
import Charts

struct LeadSegment: Identifiable {
    let lapStart: Double
    let lapEnd: Double
    let leader: String
    var id: String { "\(lapStart)-\(lapEnd)-\(leader)" }
}

struct StackedBarChartView: View {
    let totalLaps: Double = 60.0 // Total laps in the race
    let leadSegments: [LeadSegment] = [
        LeadSegment(lapStart: 1.0, lapEnd: 21.0, leader: "RUS"),
        LeadSegment(lapStart: 21.0, lapEnd: 26.0, leader: "NOR"),
        LeadSegment(lapStart: 26.0, lapEnd: 45.0, leader: "VER"),
        LeadSegment(lapStart: 45.0, lapEnd: 48.0, leader: "NOR"),
        LeadSegment(lapStart: 48.0, lapEnd: 60.0, leader: "VER") // Extend to total laps
    ]

    let leaderColors: KeyValuePairs<String, Color> = [
        "RUS": Color.tiffanyGreen,
        "NOR": .orange,
        "VER": .blue
    ]


    @State private var selectedGP: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("This chart below shows lead changes in a 2024 GrandPrix. Can you guess which race this was?")
                        .padding()

                    Chart {
                        ForEach(leadSegments) { segment in
                            BarMark(
                                xStart: .value("Lap Start", segment.lapStart),
                                xEnd: .value("Lap End", segment.lapEnd),
                                y: .value("Race", "Lead Changes")
                            )
                            .foregroundStyle(by: .value("Leader", segment.leader))
                        }
                    }
                    .chartForegroundStyleScale(leaderColors)
                    .chartXAxis {
                        AxisMarks(values: Array(stride(from: 0, through: totalLaps, by: 5)))
                    }
                    .chartYAxis {
                        AxisMarks { _ in }
                    }
                    .frame(height: 300)
                    .padding()

                    Spacer()

                    Text("Guess the GrandPrix")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // Answer Buttons
                    VStack(spacing: 16) {
                        Button("Canadian GP - 2024") {
                            selectedGP = "Canadian GP - 2024"
                        }
                        .buttonStyle(AnswerButtonStyle(isHighlighted: selectedGP == "Canadian GP - 2024"))

                        Button("Spanish GP - 2024") {
                            selectedGP = "Spanish GP - 2024"
                        }
                        .buttonStyle(AnswerButtonStyle(isHighlighted: selectedGP == "Spanish GP - 2024"))

                        Button("Silverstone GP - 2024") {
                            selectedGP = "Silverstone GP - 2024"
                        }
                        .buttonStyle(AnswerButtonStyle(isHighlighted: selectedGP == "Silverstone GP - 2024"))
                    }
                    .padding(.horizontal, 40)

                    Spacer()

                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Guess the GrandPrix")
        }
    }
}

struct LegendItemView: View {
    let color: Color
    let label: String

    var body: some View {
        HStack {
            Rectangle()
                .fill(color)
                .frame(width: 20, height: 20)
            Text(label)
        }
    }
}

struct AnswerButtonStyle: ButtonStyle {
    var isHighlighted: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(isHighlighted ? Color.orange : Color.white)
            .foregroundColor(isHighlighted ? Color.white : Color.black)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}

#Preview {
    StackedBarChartView()
}
