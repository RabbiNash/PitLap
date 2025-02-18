//
//  StandingRowModel.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import Foundation

struct StandingRowModel: Identifiable {
    let id: UUID = UUID()
    let position: String
    let fullName: String?
    let constructorName: String
    let points: String
    let wins: String
    
    init(position: String, fullName: String?, constructorName: String, points: String, wins: String) {
        self.position = position
        self.fullName = fullName
        self.constructorName = constructorName
        self.points = points
        self.wins = wins
    }
}
