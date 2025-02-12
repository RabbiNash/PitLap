//
//  ApiResponse.swift
//  PitLap
//
//  Created by Tinashe Makuti on 10/02/2025.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let success: Bool
    let data: T
}
