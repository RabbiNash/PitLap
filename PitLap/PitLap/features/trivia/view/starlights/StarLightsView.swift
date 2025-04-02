//
//  StarLightsView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 10/03/2025.
//

import SwiftUI

struct StarLightsView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack {
            Image("star")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2)
            
            Text("StarLights")
                .font(.custom("Audiowide",size: 24))
                .fontWeight(.bold)
                        
            Text("Stay ahead of the grid with StartLights: F1 calendar, live standings, smart alerts, news, widgets and more right in your Mac menu bar. Your ultimate F1 companion. StartLights puts the complete 2025 Formula 1 calendar right in your Mac's menu bar")
                .padding()
                        
            Button(action: {
                withAnimation {
                    openURL(URL(string: "https://apps.apple.com/us/app/startlights-formula-1-info/id6741859212?mt=12")!)
                }
            }) {
                Text("Explore StarLights")
                    .padding(.horizontal, 32)
                    .padding(.vertical)
                    .background(ThemeManager.shared.selectedTeamColor)
                    .foregroundColor(.white)
                    .overlay(
                        Capsule()
                            .stroke(ThemeManager.shared.selectedTeamColor, lineWidth: 1)
                    )
                    .clipShape(Capsule())
            }
            
            Spacer()

        }.ignoresSafeArea()
    }
}

#Preview {
    StarLightsView()
}


