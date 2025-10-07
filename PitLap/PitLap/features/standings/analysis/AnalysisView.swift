//
//  AIStandingsAnalysisView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI
import Foundation
import Combine
import FoundationModels
import MarkdownUI


@available(iOS 26.0, *)
struct AnalysisView: View {
    @StateObject private var viewModel: AnalysisViewModel
    @State private var analysisGenerator: AnalysisGenerator = AnalysisGenerator()
    @State private var searchText: String = ""
    @State private var isGenerating: Bool = false
  
    private let model = SystemLanguageModel.default
    
    init() {
        _viewModel = .init(wrappedValue: .init())
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [ThemeManager.shared.selectedTeamColor.opacity(0.5), Color.clear]),
                        startPoint: .top,
                        endPoint: .center
                    )
                )
                .ignoresSafeArea(.all)
                .shadow(radius: 8)
            
            VStack(spacing: 20) {
                bodySection
                Spacer()
            }
            .padding(24)
        }
        .navigationTitle("Formula AI")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Ask about the current F1 standings")
        .onSubmit(of: .search) {
            generateAnalysis()
        }
    }
    
    private var header: some View {
        VStack(alignment: .center, spacing: 8) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 64, height: 64)
            
            Text("Ask questions about the current F1 standings and get AI-powered insights")
                .styleAsDisplayMedium()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var bodySection: some View {
        switch model.availability {
        case .available:
            responseSection
        case .unavailable(let error):
            VStack(alignment: .leading, spacing: 12) {
                switch error {
                case .deviceNotEligible:
                    Text("Device is not eligible for this feature")
                        .font(.headline)
                        .foregroundColor(.primary)
                case .appleIntelligenceNotEnabled:
                    Text("Please enable Apple Intelligence before using the feature")
                        .font(.headline)
                        .foregroundColor(.primary)
                case .modelNotReady:
                    Text("Models are currently loading please wait")
                        .font(.headline)
                        .foregroundColor(.primary)
                @unknown default:
                    Text("Device is not eligible for this feature")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
        }
    }
    
    
    private var responseSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    if let analysis = analysisGenerator.analysis {
                        Markdown(analysis)
                            .textSelection(.enabled)
                    } else {
                        header
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
            }
        }
    }
    
    private func generateAnalysis() {
        guard !searchText.isEmpty else { return }
        
        isGenerating = true
        analysisGenerator.clearResponse()
        
        Task {
            await analysisGenerator.generateAnalysis(for: searchText)
            await MainActor.run {
                isGenerating = false
            }
        }
    }
}

#Preview {
    NavigationView {
        if #available(iOS 26.0, *) {
            AnalysisView()
        } else {
            EmptyView()
        }
    }
}
