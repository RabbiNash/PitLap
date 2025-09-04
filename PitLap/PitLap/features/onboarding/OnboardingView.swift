//
//  OnboardingView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 19/03/2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
            VStack(alignment: .center) {
                Text(LocalizedStrings.onboardingTitle)
                    .fontWeight(.bold)
                    .font(.custom("Audiowide", size: 48))
                
                Text(LocalizedStrings.onboardingSubtitle)
                    .multilineTextAlignment(.center)
                
                Picker(LocalizedStrings.team, selection: $viewModel.team) {
                    ForEach(F1Team.allCases, id: \.self) { team in
                        Text(team.rawValue.capitalized)
                            .tag(team.rawValue)
                    }
                }
                .pickerStyle(.wheel)
                
                Button {
                    viewModel.completeOnboarding()
                    dismiss()
                } label : {
                    Text(LocalizedStrings.confirm)
                }
                .padding()
                .buttonStyle(PrimaryButtonStyle())
            }.padding(24)
    }
}

#Preview {
    OnboardingView()
}
