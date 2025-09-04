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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        HStack(spacing: UIDevice.isIPad ? 8 : 0) {
            ForEach(BottomNavTab.allCases, id: \.self) { tab in
                Button {
                    activeTab = tab
                } label: {
                    HStack(spacing: UIDevice.isIPad ? 8 : 5) {
                        Image(systemName: tab.icon)
                            .font(UIDevice.isIPad ? .title2.bold() : .title3.bold())
                            .frame(width: UIDevice.isIPad ? 36 : 30, height: UIDevice.isIPad ? 36 : 30)

                        if activeTab == tab || UIDevice.isIPad {
                            Text(tab.rawValue)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .font(UIDevice.isIPad ? .body : .caption)
                        }
                    }
                    .foregroundStyle(activeTab == tab ? activeForegroundColor : .secondary)
                    .padding(.vertical, UIDevice.isIPad ? 12 : 8)
                    .padding(.leading, UIDevice.isIPad ? 16 : 10)
                    .padding(.trailing, UIDevice.isIPad ? 20 : 15)
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
                .shadow(.drop(color: .black.opacity(0.08), radius: UIDevice.isIPad ? 8.0 : 5.0, x: UIDevice.isIPad ? 8 : 5, y: UIDevice.isIPad ? 8 : 5))
                .shadow(.drop(color: .black.opacity(0.05), radius: UIDevice.isIPad ? 8.0 : 5.0, x: UIDevice.isIPad ? -8 : -5, y: UIDevice.isIPad ? -8 : -5)),
            in: .capsule
        )
        .padding(.horizontal, UIDevice.isIPad ? 20 : 0)
        .padding(.bottom, UIDevice.isIPad ? 20 : 0)
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: activeTab)
    }
}

#Preview {
    ContentView()
}
