//
//  AIStandingsAnalysisViewModel.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation
import SwiftUI

@MainActor
final class AnalysisViewModel: ObservableObject {
    @Published var response: String = ""
    @Published var isGenerating: Bool = false
    
    private var standingsData: [StandingRowModel] = []
    private var aiTool: AIStandingsAnalysisTool
    
    init(standingsData: [StandingRowModel] = []) {
        self.standingsData = standingsData
        self.aiTool = AIStandingsAnalysisTool(standingsData: standingsData)
    }
    
    func generateAnalysis(for userInput: String) async {
        isGenerating = true
        response = ""
        
        do {
            let stream = try await aiTool.generateAnalysis(for: userInput)
            
            for try await chunk in stream {
                response += chunk
            }
        } catch {
            response = "Sorry, I encountered an error while generating the analysis: \(error.localizedDescription)"
        }
        
        isGenerating = false
    }
    
    func clearResponse() {
        response = ""
    }
    
    func updateStandingsData(_ newData: [StandingRowModel]) {
        standingsData = newData
        aiTool = AIStandingsAnalysisTool(standingsData: newData)
    }
}
