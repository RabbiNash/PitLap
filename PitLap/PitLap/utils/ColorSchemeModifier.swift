//
//  Untitled.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import SwiftUI

struct ColorSchemeModifier: ViewModifier {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
