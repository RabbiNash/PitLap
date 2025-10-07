//
//  AnalysisGenerator.swift
//  PitLap
//
//  Created by Tinashe Makuti on 07/10/2025.
//

import FoundationModels
import Foundation
import Observation
import PitlapKit

@Observable
@MainActor
@available(iOS 26.0, *)
final class AnalysisGenerator {
    
    private var session: LanguageModelSession
    private(set) var analysis: String?
    
    init() {
        let instructions =
                 """
                You are an expert F1 analyst. Based on the current standings data provided, answer the user's question with detailed insights and analysis.
        
                Please provide a comprehensive analysis that includes:
                - Direct answers to the user's question
                - Statistical insights from the standings
                - Context about driver/constructor performance
                - Interesting patterns or trends you notice
                - Any relevant F1 knowledge that adds value
                - When asked about who theoretically has a chance to win, look a the drivers standings and correlate with how many races are left in the season based on the findRemainingRacesSchedule. Only the race events returned by this tool are the regarded as the remaining races in the season
                - The current year is 2025
                - return a properly formatted markdown responses with line breaks as well.
                
                Keep the response engaging, informative, and easy to understand for F1 fans.
        """
        let driverStandingTool = DriverStandingTool()
        let constructorStandingTool = ConstructorDataTool()
        let scheduleTool = ScheduleTool()
        let remainingRacesSchedule = RemainingRacesScheduleTool()
        
        self.session = LanguageModelSession.init(tools: [driverStandingTool, constructorStandingTool, remainingRacesSchedule, scheduleTool], instructions: instructions)
    }
    
    func generateAnalysis(for prompt: String) async {
         do {
            let response = session.streamResponse(to: prompt)
             for try await partialResponse in response {
                 self.analysis = partialResponse.content
             }
         } catch {
           print(error)
         }
    }
    
    func clearResponse() {
        self.analysis = nil
    }
}
