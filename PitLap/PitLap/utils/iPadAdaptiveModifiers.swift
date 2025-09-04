//
//  iPadAdaptiveModifiers.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import SwiftUI

// MARK: - Device Type Detection
extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

// MARK: - Screen Size Categories
enum ScreenSizeCategory {
    case compact
    case regular
    case large
    
    static var current: ScreenSizeCategory {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let minDimension = min(screenWidth, screenHeight)
        
        if minDimension < 400 {
            return .compact
        } else if minDimension < 800 {
            return .regular
        } else {
            return .large
        }
    }
}

// MARK: - iPad Adaptive Modifiers
struct iPadAdaptiveModifier: ViewModifier {
    let compact: AnyView
    let regular: AnyView
    let large: AnyView
    
    func body(content: Content) -> some View {
        Group {
            switch ScreenSizeCategory.current {
            case .compact:
                compact
            case .regular:
                regular
            case .large:
                large
            }
        }
    }
}

extension View {
    func iPadAdaptive<Compact: View, Regular: View, Large: View>(
        @ViewBuilder compact: () -> Compact,
        @ViewBuilder regular: () -> Regular,
        @ViewBuilder large: () -> Large
    ) -> some View {
        self.modifier(
            iPadAdaptiveModifier(
                compact: AnyView(compact()),
                regular: AnyView(regular()),
                large: AnyView(large())
            )
        )
    }
    
    func iPadAdaptive<Regular: View, Large: View>(
        @ViewBuilder regular: () -> Regular,
        @ViewBuilder large: () -> Large
    ) -> some View {
        self.modifier(
            iPadAdaptiveModifier(
                compact: AnyView(regular()),
                regular: AnyView(regular()),
                large: AnyView(large())
            )
        )
    }
}

// MARK: - iPad-Specific Layout Modifiers
struct iPadNavigationModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    func body(content: Content) -> some View {
        if UIDevice.isIPad && horizontalSizeClass == .regular {
            NavigationSplitView {
                // Sidebar content will be provided by the view using this modifier
                EmptyView()
            } detail: {
                content
            }
        } else {
            content
        }
    }
}

extension View {
    func iPadNavigation() -> some View {
        self.modifier(iPadNavigationModifier())
    }
}

// MARK: - Responsive Grid
struct ResponsiveGrid<Item: Identifiable, ItemView: View>: View {
    let items: [Item]
    let itemView: (Item) -> ItemView
    let minItemWidth: CGFloat
    
    init(items: [Item], minItemWidth: CGFloat = 300, @ViewBuilder itemView: @escaping (Item) -> ItemView) {
        self.items = items
        self.minItemWidth = minItemWidth
        self.itemView = itemView
    }
    
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.adaptive(minimum: minItemWidth), spacing: 16)
            ],
            spacing: 16
        ) {
            ForEach(items) { item in
                itemView(item)
            }
        }
        .padding()
    }
}

// MARK: - iPad-Specific Padding
struct iPadPaddingModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    func body(content: Content) -> some View {
        if UIDevice.isIPad {
            content
                .padding(.horizontal, horizontalSizeClass == .regular ? 40 : 20)
        } else {
            content
                .padding(.horizontal, 16)
        }
    }
}

extension View {
    func iPadPadding() -> some View {
        self.modifier(iPadPaddingModifier())
    }
}

// MARK: - Adaptive Font Sizes
struct AdaptiveFontModifier: ViewModifier {
    let baseSize: CGFloat
    
    func body(content: Content) -> some View {
        let multiplier: CGFloat = UIDevice.isIPad ? 1.2 : 1.0
        content
            .font(.system(size: baseSize * multiplier))
    }
}

extension View {
    func adaptiveFont(size: CGFloat) -> some View {
        self.modifier(AdaptiveFontModifier(baseSize: size))
    }
}
