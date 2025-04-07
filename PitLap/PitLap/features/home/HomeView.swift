//
//  HomeView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 03/04/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                standingsHeader
                Text("Next Race")
                    .font(.custom("Audiowide",size: 28))
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                
                Spacer()
                
            }
        }
    }
    
    var standingsHeader: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(ThemeManager.shared.selectedTeamColor.gradient)
                .shadow(radius: 8)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Lando")
                        .font(.custom("Audiowide", size: 24))
                    Text("Norris")
                        .font(.custom("Audiowide", size: 24))
                        .bold()
                }
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Pos")
                            .foregroundColor(.white)
                        Text("01")
                            .foregroundColor(.white)
                            .font(.custom("Noto Sans", size: 32))
                            .bold()
                    }.padding(.trailing)
                    
                    VStack(alignment: .leading) {
                        Text("Pts")
                            .foregroundColor(.white)
                        Text("255")
                            .foregroundColor(.white)
                            .font(.custom("Noto Sans", size: 32))
                            .bold()
                    }
                    
                    Spacer()
                    
                    Image(systemName: "bolt.fill")
                        .resizable()
                        .frame(width: 48, height: 82)
                        .foregroundColor(.white)
                }
                .padding(.top, 32)
                
            }.padding()
        }.frame(height: 100)
        .padding()
    }
}

#Preview {
    HomeView()
}
