//
//  AIStandingsAnalysisTool.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation
import SwiftUI

final class AIStandingsAnalysisTool {
    private let standingsData: [StandingRowModel]
    
    init(standingsData: [StandingRowModel]) {
        self.standingsData = standingsData
    }
    
    func generateAnalysis(for userInput: String) async throws -> AsyncThrowingStream<String, Error> {
        let prompt = buildPrompt(from: userInput)
        return try await AIService.shared.streamResponse(for: prompt)
    }
    
    
    private func buildPrompt(from userInput: String) -> String {
        let standingsContext = buildStandingsContext()
        
        return """
        You are an expert F1 analyst. Based on the current standings data provided, answer the user's question with detailed insights and analysis.
        
        Current Standings Data:
        \(standingsContext)
        
        User Question: \(userInput)
        
        Please provide a comprehensive analysis that includes:
        - Direct answers to the user's question
        - Statistical insights from the standings
        - Context about driver/constructor performance
        - Interesting patterns or trends you notice
        - Any relevant F1 knowledge that adds value
        
        Keep the response engaging, informative, and easy to understand for F1 fans.
        """
    }
    
    private func buildStandingsContext() -> String {
        var context = ""
        
        for (index, standing) in standingsData.enumerated() {
            if let fullName = standing.fullName {
                context += "\(standing.position). \(fullName) (\(standing.constructorName)) - \(standing.points) points, \(standing.wins) wins\n"
            } else {
                context += "\(standing.position). \(standing.constructorName) - \(standing.points) points, \(standing.wins) wins\n"
            }
        }
        
        return context
    }
    
}
