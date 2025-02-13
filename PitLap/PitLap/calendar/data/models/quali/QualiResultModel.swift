//
//  File.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation

struct QualiResultModel: Codable {
    let teamName: String
    let headshotUrl: String
    let q1: String?
    let q2: String?
    let q3: String?
    let position: Int
    let fullName: String
    
    init(teamName: String, headshotUrl: String, q1: String?, q2: String?, q3: String?, position: Int, fullName: String) {
        self.teamName = teamName
        self.headshotUrl = headshotUrl
        self.q1 = q1
        self.q2 = q2
        self.q3 = q3
        self.position = position
        self.fullName = fullName
    }
}
