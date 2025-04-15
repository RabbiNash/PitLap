//
//  RatingManager.swift
//  PitLap
//
//  Created by Tinashe Makuti on 15/04/2025.
//

import Foundation
import SwiftUI
import StoreKit

final class RatingManager {
    static let shared = RatingManager()
    private let key = "isStoreRatingRequested"

    private init() {}

    func requestAppStoreRating() {
        let alreadyRequested = UserDefaults.standard.bool(forKey: key)
        guard !alreadyRequested else { return }

        if let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
            UserDefaults.standard.set(true, forKey: key)
        }
    }
}
