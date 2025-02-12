//
//  ConstructorStandingModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import Foundation

struct ConstructorStandingModel: Codable {
    let position: Int
    let positionText: String
    let points: Int
    let wins: Int
    let constructorId: String
    let constructorName: String
    
    init(position: Int, positionText: String, points: Int, wins: Int, constructorId: String, constructorName: String) {
        self.position = position
        self.positionText = positionText
        self.points = points
        self.wins = wins
        self.constructorId = constructorId
        self.constructorName = constructorName
    }
}
