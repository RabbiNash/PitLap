//
//  BottomNavTabBar.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI

struct BottomNavTabBar: View {
    var activeForegroundColor: Color = .white
    var activeBackkgroundColor: Color = ThemeManager.shared.selectedTeamColor

    @Binding var activeTab: BottomNavTab
    @Namespace private var animation
    @State private var tabLocation: CGRect = .zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(BottomNavTab.allCases, id: \.self) { tab in
                Button {
                    activeTab = tab
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: tab.icon)
                            .font(.title3.bold())
                            .frame(width: 30, height: 30)

                        if activeTab == tab {
                            Text(tab.rawValue)
                                .fontWeight(.semibold)
                                .lineLimit(1)

                        }
                    }
                    .foregroundStyle(activeTab == tab ? activeForegroundColor : .secondary)
                    .padding(.vertical, 8)
                    .padding(.leading, 10)
                    .padding(.trailing, 15)
                    .contentShape(.rect)
                    .background {
                        if activeTab == tab {
                            Capsule()
                                .fill( LinearGradient(
                                    gradient: Gradient(
                                        colors: [activeBackkgroundColor, activeBackkgroundColor.opacity(0.7)]),
                                    startPoint: .top,
                                    endPoint: .center
                                ))
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                }.buttonStyle(.plain)
            }
        }
        .background(alignment: .leading) {
            Capsule()
                .fill(activeBackkgroundColor.gradient)
                .frame(width: tabLocation.width, height: tabLocation.height)
                .offset(x: tabLocation.minX)

        }
        .coordinateSpace(.named("TABBARVIEW"))
        .background(
            .background
                .shadow(.drop(color: .black.opacity(0.08), radius: 5.0, x: 5, y: 5))
                .shadow(.drop(color: .black.opacity(0.05), radius: 5.0, x: -5, y: -5)),
            in: .capsule
        )
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: activeTab)
    }
}

#Preview {
    ContentView()
}
