//
//  RaceReactionViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 02/04/2025.
//

import SwiftUI
import GameKit

@MainActor
class RaceReactionViewModel: ObservableObject {
    @Published var activeIndex: Int = -1
    @Published var reactionTime: TimeInterval?
    @Published var isSequenceRunning = false
    @Published var isJumpStart: Bool = false
    
    private var startTime: Date?
    private var sequenceTask: Task<Void, Never>?

    func handleButtonPress() {
        if isSequenceRunning {
            guard startTime != nil else {
                isJumpStart = true
                activeIndex = -1
                resetState()
                stopSequence()
                return
            }
            stopTimer()
        } else {
            isJumpStart = false
            sequenceTask = Task { await startSequence() }
        }
    }
    
    private func startSequence() async {
        resetState()
        
        for i in 0..<4 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            activeIndex = i
            triggerHapticFeedback()
        }
        
        let randomDelay = Double.random(in: 0.5...3)
        try? await Task.sleep(nanoseconds: UInt64(randomDelay * 1_000_000_000))
        
        activeIndex = -1
        startTimer()
    }
    
    private func resetState() {
        reactionTime = nil
        startTime = nil
        isSequenceRunning = true
    }
    
    private func startTimer() {
        startTime = Date()
    }
    
    private func stopTimer() {
        guard let startTime = startTime else { return }
        reactionTime = Date().timeIntervalSince(startTime)
        self.startTime = nil
        isSequenceRunning = false
    }
    
    private func stopSequence() {
        sequenceTask?.cancel()
        sequenceTask = nil
        activeIndex = -1
        isSequenceRunning = false
    }
    
    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}
