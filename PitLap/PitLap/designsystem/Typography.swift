//
//  Typography.swift
//  PitLap
//
//  Created by Tinashe Makuti on 24/04/2025.
//

import Foundation
import SwiftUI

extension Text {
    // Display
    func styleAsDisplayHero() -> some View {
        self.font(.custom("AudioWide", size: 48))
            .fontWeight(.regular)
    }
        
    func styleAsDisplayLarge() -> some View {
        self.font(.custom("AudioWide", size: 30))
            .fontWeight(.regular)
    }
    
    func styleAsDisplayMedium() -> some View {
        self.font(.custom("AudioWide", size: 24))
            .fontWeight(.regular)
    }
    
    func styleAsDisplaySmall() -> some View {
        self.font(.custom("AudioWide", size: 20))
            .fontWeight(.regular)
    }
    
    func styleAsDisplaySmaller() -> some View {
        self.font(.custom("AudioWide", size: 18))
            .fontWeight(.regular)
    }
    
    
    func styleAsDisplaySmallest() -> some View {
        self.font(.custom("AudioWide", size: 12))
            .fontWeight(.regular)
    }

    // Headline
    func styleAsHeadlineLarge() -> some View {
        self.font(.custom("Noto Sans", size: 18))
            .fontWeight(.medium)
    }
    func styleAsHeadlineMedium() -> some View {
        self.font(.custom("Noto Sans", size: 16))
            .fontWeight(.medium)
    }
    func styleAsHeadlineSmall() -> some View {
        self.font(.custom("Noto Sans", size: 14))
            .fontWeight(.medium)
    }

    // Title
    func styleAsTitleLarge() -> some View {
        self.font(.custom("Noto Sans", size: 16))
            .fontWeight(.regular)
    }
    func styleAsTitleMedium() -> some View {
        self.font(.custom("Noto Sans", size: 14))
            .fontWeight(.medium)
    }
    func styleAsTitleSmall() -> some View {
        self.font(.custom("Noto Sans", size: 12))
            .fontWeight(.medium)
    }

    // Body
    func styleAsBodyLarge() -> some View {
        self.font(.custom("Noto Sans", size: 16))
            .fontWeight(.regular)
    }
    
    func styleAsBodyMedium() -> some View {
        self.font(.custom("Noto Sans", size: 14))
            .fontWeight(.regular)
    }
    
    func styleAsBodySmall() -> some View {
        self.font(.custom("Noto Sans", size: 12))
            .fontWeight(.regular)
    }

    // Label
    func styleAsLabelLarge() -> some View {
        self.font(.custom("Noto Sans", size: 14))
            .fontWeight(.medium)
    }
    
    func styleAsLabelMedium() -> some View {
        self.font(.custom("Noto Sans", size: 12))
            .fontWeight(.medium)
    }
    
    func styleAsLabelSmall() -> some View {
        self.font(.custom("Noto Sans", size: 10))
            .fontWeight(.regular)
    }
    
    func styleAsLabelMinimum() -> some View {
        self.font(.custom("Noto Sans", size: 8))
            .fontWeight(.regular)
    }
}
