//
//  RaceReactionView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 01/04/2025.
//

import SwiftUI
import GameKit

struct RaceReactionView: View {
    @StateObject private var viewModel = RaceReactionViewModel()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
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
            
            ScrollView(showsIndicators: false) {
                VStack {
                    raceLights
                    jumpStartView
                    Spacer()
                    controlButton
                    Spacer()
                }.padding(24)
            }
        }
    }
    
    private var raceLights: some View {
        HStack(spacing: 16) {
            Spacer()
            ForEach(0..<4, id: \..self) { index in
                StartLightView(isActive: viewModel.activeIndex >= index)
                Spacer()
            }
        }
        .animation(.easeInOut, value: viewModel.activeIndex)
    }
    
    private var jumpStartView: some View {
        HStack {
            if let reactionTime = viewModel.reactionTime {
                Text("\(String(format: "%.3f", reactionTime))s")
                    .font(.custom("Audiowide", size: 32))
            } else if viewModel.isJumpStart {
                Text("Oops Jump Start")
                    .font(.custom("Audiowide", size: 32))
            }
        }
    }
    
    private var controlButton: some View {
        Button(action: viewModel.handleButtonPress) {
            Text(viewModel.isSequenceRunning ? "Go Go" : "Start")
                .font(.custom("Audiowide", size: 32))
                .foregroundColor(.white)
                .frame(width: 240, height: 240)
                .background(
                    Circle()
                        .fill(ThemeManager.shared.selectedTeamColor))
                .shadow(radius: 5)
        }
        .padding(.top, 32)
    }
}

#Preview {
    RaceReactionView()
}

