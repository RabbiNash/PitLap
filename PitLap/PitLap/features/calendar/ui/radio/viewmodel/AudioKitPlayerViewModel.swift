//
//  AudioKitPlayerViewModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 08/07/2025.
//


import Foundation
import AudioKit
import AVFoundation
import Combine

class AudioFilePlaybackConductor: ObservableObject, HasAudioEngine {
    @Published var isPlaying = false {
        didSet {
            isPlaying ? player.play() : player.stop()
        }
    }

    let engine = AudioEngine()
    let player = AudioPlayer()
    var file: AVAudioFile?

    init() {
        engine.output = player
        try? engine.start()
    }

    func loadFile(url: URL) {
        do {
            file = try AVAudioFile(forReading: url)
            if let file {
                player.scheduleFile(file, at: nil)
            }
        } catch {
            print("Failed to load audio file: \(error)")
        }
    }
}
