//
//  AIService.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation
import SwiftUI
import FoundationModels

protocol AIServiceProtocol {
    func generateResponse(for prompt: String) async throws -> String
    func streamResponse(for prompt: String) async throws -> AsyncThrowingStream<String, Error>
}

final class AIService: AIServiceProtocol {
    static let shared = AIService()
    
    private init() {}
    
    func generateResponse(for prompt: String) async throws -> String {
        return try await generateMockResponse(prompt: prompt)
    }
    
    func streamResponse(for prompt: String) async throws -> AsyncThrowingStream<String, Error> {
        return AsyncThrowingStream { continuation in
            Task {
                do {
                    if #available(iOS 18.0, *) {
                        // Use Foundation Models streaming
                        try await streamWithFoundationModels(prompt: prompt, continuation: continuation)
                    } else {
                        // Fallback to mock streaming for older iOS versions
                        let response = try await generateResponse(for: prompt)
                        await streamText(response, continuation: continuation)
                    }
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    @available(iOS 18.0, *)
    private func streamWithFoundationModels(prompt: String, continuation: AsyncThrowingStream<String, Error>.Continuation) async throws {
        do {
//            let model = try await FoundationModel.load(.small)
//            let stream = model.stream(prompt: prompt)
//            
//            for try await chunk in stream {
//                continuation.yield(chunk)
//            }
            continuation.finish()
        } catch {
            print("Foundation Models streaming error: \(error.localizedDescription)")
            // Fallback to mock streaming
            let response = try await generateEnhancedMockResponse(prompt: prompt)
            await streamText(response, continuation: continuation)
        }
    }
    
    private func generateMockResponse(prompt: String) async throws -> String {
        // Simulate API delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Generate a more sophisticated mock response based on the prompt
        return try await generateEnhancedMockResponse(prompt: prompt)
    }
    
    private func generateEnhancedMockResponse(prompt: String) async throws -> String {
        let lowercasedPrompt = prompt.lowercased()
        
        // Analyze the prompt to provide more relevant responses
        if lowercasedPrompt.contains("championship") || lowercasedPrompt.contains("leader") {
            return generateChampionshipAnalysis(prompt: prompt)
        } else if lowercasedPrompt.contains("team") || lowercasedPrompt.contains("constructor") {
            return generateConstructorAnalysis(prompt: prompt)
        } else if lowercasedPrompt.contains("points") || lowercasedPrompt.contains("score") {
            return generatePointsAnalysis(prompt: prompt)
        } else if lowercasedPrompt.contains("wins") || lowercasedPrompt.contains("victory") {
            return generateWinsAnalysis(prompt: prompt)
        } else if lowercasedPrompt.contains("compare") || lowercasedPrompt.contains("vs") {
            return generateComparisonAnalysis(prompt: prompt)
        } else {
            return generateGeneralAnalysis(prompt: prompt)
        }
    }
    
    private func generateChampionshipAnalysis(prompt: String) -> String {
        return """
        🏆 **Championship Analysis**
        
        Based on the current standings, here's a comprehensive look at the championship battle:
        
        **Current Leader:**
        The championship leader has demonstrated exceptional consistency and performance throughout the season. Their points advantage reflects both individual driver skill and team excellence.
        
        **Key Factors:**
        • **Consistency**: Regular podium finishes and point-scoring positions
        • **Race Craft**: Ability to maximize points in every race weekend
        • **Team Performance**: Strong car development and strategic execution
        • **Mental Strength**: Handling pressure in high-stakes situations
        
        **Championship Dynamics:**
        The current standings show a clear hierarchy, but Formula 1 is known for its unpredictability. Each race weekend can dramatically change the championship picture, making every point crucial.
        
        **Season Context:**
        This championship battle represents the pinnacle of motorsport competition, where the best drivers and teams compete for the ultimate prize in racing.
        """
    }
    
    private func generateConstructorAnalysis(prompt: String) -> String {
        return """
        🏭 **Constructor Championship Analysis**
        
        The constructor standings reveal fascinating insights into team performance and development:
        
        **Team Performance Metrics:**
        • **Car Development**: How well teams have evolved their machinery
        • **Driver Pairing**: The combined efforts of both team drivers
        • **Strategic Execution**: Pit wall decisions and race management
        • **Reliability**: Consistency in finishing races and scoring points
        
        **Competitive Landscape:**
        The constructor championship often tells a different story than the driver standings, highlighting the importance of team effort and car performance across both drivers.
        
        **Technical Insights:**
        Strong constructor performance typically indicates excellent engineering, strategic planning, and operational capabilities. It's a true measure of a team's overall strength.
        
        **Season Development:**
        Teams that show improvement in the constructor standings often demonstrate strong development programs and effective use of resources throughout the season.
        """
    }
    
    private func generatePointsAnalysis(prompt: String) -> String {
        return """
        📊 **Points Analysis**
        
        The points distribution in Formula 1 tells a compelling story about performance and consistency:
        
        **Scoring System:**
        • **25 points** for 1st place (race win)
        • **18 points** for 2nd place
        • **15 points** for 3rd place
        • **12 points** for 4th place
        • **10 points** for 5th place
        • **8 points** for 6th place
        • **6 points** for 7th place
        • **4 points** for 8th place
        • **2 points** for 9th place
        • **1 point** for 10th place
        
        **Key Insights:**
        • **Wins are crucial**: The 25-point reward for victory makes race wins extremely valuable
        • **Consistency matters**: Regular podium finishes accumulate significant points
        • **Every point counts**: The difference between positions can be decisive
        • **Strategic importance**: Teams must balance risk and reward in every race
        
        **Championship Impact:**
        The points system rewards both excellence (wins) and consistency (regular scoring), creating a balanced championship that values different types of performance.
        """
    }
    
    private func generateWinsAnalysis(prompt: String) -> String {
        return """
        🏁 **Race Wins Analysis**
        
        Race victories are the ultimate measure of success in Formula 1:
        
        **The Value of Wins:**
        • **25 points**: Each win provides maximum championship points
        • **Momentum**: Victories build confidence and team morale
        • **Legacy**: Wins define a driver's and team's place in history
        • **Strategy**: Teams often prioritize wins over consistent scoring
        
        **Winning Characteristics:**
        • **Pure Speed**: Ability to be fastest when it matters most
        • **Race Craft**: Overtaking, defending, and strategic thinking
        • **Mental Strength**: Handling pressure in critical moments
        • **Team Support**: Perfect execution from the entire team
        
        **Season Context:**
        The number of wins often correlates with championship success, but consistency can sometimes overcome a win deficit. The balance between risk and reward is crucial.
        
        **Historical Perspective:**
        Great champions are remembered for their wins, but also for their ability to score points when victory isn't possible.
        """
    }
    
    private func generateComparisonAnalysis(prompt: String) -> String {
        return """
        ⚖️ **Comparative Analysis**
        
        Comparing drivers and teams reveals fascinating insights into Formula 1 performance:
        
        **Performance Metrics:**
        • **Points per race**: Average scoring efficiency
        • **Consistency**: Regular point-scoring ability
        • **Peak performance**: Best race results
        • **Development trajectory**: Improvement over the season
        
        **Key Comparisons:**
        • **Driver vs Driver**: Individual skill and performance
        • **Team vs Team**: Car development and strategy
        • **Season vs Season**: Year-over-year improvement
        • **Different eras**: Historical context and evolution
        
        **Analysis Framework:**
        When comparing Formula 1 competitors, it's important to consider:
        - Car performance and reliability
        - Team strategy and execution
        - Driver skill and consistency
        - External factors and circumstances
        
        **Championship Impact:**
        These comparisons often predict future performance and help understand the competitive landscape of Formula 1.
        """
    }
    
    private func generateGeneralAnalysis(prompt: String) -> String {
        return """
        🏎️ **Formula 1 Standings Analysis**
        
        The current standings provide a comprehensive view of the Formula 1 championship:
        
        **Championship Dynamics:**
        Formula 1 standings reflect the complex interplay between driver skill, car performance, team strategy, and reliability. Each position tells a story of performance and potential.
        
        **Key Observations:**
        • **Competitive Balance**: The standings show the competitive nature of Formula 1
        • **Performance Gaps**: Clear differences between top teams and midfield
        • **Development Trajectories**: Teams showing improvement or decline
        • **Championship Implications**: How current positions affect title chances
        
        **Season Context:**
        These standings represent the cumulative result of all races so far, but Formula 1 is known for its unpredictability. Each race weekend can dramatically change the championship picture.
        
        **Strategic Insights:**
        Teams use standings data to make strategic decisions about car development, driver contracts, and race strategies. Every point matters in the pursuit of championship success.
        
        **Fan Perspective:**
        For fans, the standings create narratives, rivalries, and storylines that make Formula 1 one of the most compelling sports in the world.
        """
    }
    
    private func streamText(_ text: String, continuation: AsyncThrowingStream<String, Error>.Continuation) async {
        let words = text.components(separatedBy: .whitespaces)
        var currentChunk = ""
        
        for (index, word) in words.enumerated() {
            currentChunk += word + " "
            
            // Send chunk every few words to simulate streaming
            if index % 3 == 0 || index == words.count - 1 {
                continuation.yield(currentChunk)
                currentChunk = ""
                
                // Small delay to simulate streaming
                try? await Task.sleep(nanoseconds: 50_000_000) // 50ms
            }
        }
        
        continuation.finish()
    }
}
