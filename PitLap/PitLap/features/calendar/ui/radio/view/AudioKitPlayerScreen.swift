//
//  AudioKitPlayerScreen.swift
//  PitLap
//
//  Created by Tinashe Makuti on 08/07/2025.
//

import SwiftUI
import AudioKitUI
import AVKit

struct AudioPlaybackView: View {
    @StateObject var conductor = AudioFilePlaybackConductor()

    private let audioUrl: String
    
    init(audioUrl: String) {
        self.audioUrl = audioUrl
    }

    var body: some View {
        VStack {
            Text(conductor.isPlaying ? "Stop" : "Play")
                .onTapGesture {
                    conductor.isPlaying.toggle()
                }
                .padding()

            NodeOutputView(conductor.player)
                .frame(height: 200)
        }
        .onAppear {
            setupAudioSession()
            downloadAudioAndLoad()
        }
        .onDisappear {
            releaseAudioSession()
        }
    }

    func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [])
            try session.setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }
    
    func releaseAudioSession() {
           do {
               try AVAudioSession.sharedInstance().setActive(false)
           } catch {
               print("⚠️ Failed to deactivate audio session: \(error)")
           }
       }
    
    private func downloadAudioAndLoad() {
        URLSession.shared.downloadTask(with: URL(string: audioUrl)!) { localURL, _, _ in
            if let localURL {
                DispatchQueue.main.async {
                    conductor.loadFile(url: localURL)
                }
            }
        }.resume()
    }
}
