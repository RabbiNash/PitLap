//
//  RaceWeekendHeaderViewModel.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import Combine

class RaceWeekendHeaderViewModel: ObservableObject {
    @Published var countdownText: String = ""

    @Published var days: String = ""
    @Published var hours: String = ""
    @Published var minutes: String = ""
    @Published var seconds: String = ""

    private var cancellable: AnyCancellable?

    deinit {
        stopCountdown()
    }

    func startCountdown(targetDate: Date?) {
        guard targetDate != nil else { return }
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateCountdown(targetDate: targetDate!)
            }
    }

    private func stopCountdown() {
        cancellable?.cancel()
    }

    private func updateCountdown(targetDate: Date) {
        let currentDate = Date()
        let interval = targetDate.timeIntervalSince(currentDate)

        if interval <= 0 {
            countdownText = "The event has started!"
            stopCountdown()
        } else {
            let calculatedDays = Int(interval) / 86400
            let calculatedhours = (Int(interval) % 86400) / 3600
            let calculatedminutes = (Int(interval) % 3600) / 60
            let calculatedseconds = Int(interval) % 60

            days = String(format: "%02d", calculatedDays)
            hours = String(format: "%02d", calculatedhours)
            minutes = String(format: "%02d", calculatedminutes)
            seconds = String(format: "%02d", calculatedseconds)
        }
    }
}
