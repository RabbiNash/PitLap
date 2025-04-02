//
//  RaceTrack.swift
//  PitLap
//
//  Created by Tinashe Makuti on 01/04/2025.
//

import Foundation

enum RaceTrack: String, CaseIterable {
    case silverstone = "silverston"
    case abuDhabi = "abu"
    case austin = "austin"
    case baku = "baku"
    case barcelona = "barcelon"
    case brazil = "brazil"
    case budapest = "budapest"
    case canada = "canada"
    case china = "china"
    case imola = "imola"
    case jeddah = "jeddah"
    case melbourne = "melbourne"
    case mexico = "mexico"
    case miami = "miami"
    case monaco = "monaco"
    case monza = "monza"
    case qatar = "qatar"
    case sakhir = "sakhir"
    case singapore = "singapore"
    case spa = "spa"
    case spielberg = "spielberg"
    case suzuka = "suzuka"
    case vegas = "vegas"
    case zandvoort = "zandvoort"

    var fileName: String {
        return self.rawValue
    }

    static func fromEventName(_ eventName: String) -> RaceTrack? {
        let mapping: [String: RaceTrack] = [
            "Pre-Season Testing": .sakhir,
            "Bahrain Grand Prix": .sakhir,
            "Saudi Arabian Grand Prix": .jeddah,
            "Australian Grand Prix": .melbourne,
            "Japanese Grand Prix": .suzuka,
            "Chinese Grand Prix": .china,
            "Miami Grand Prix": .miami,
            "Emilia Romagna Grand Prix": .imola,
            "Monaco Grand Prix": .monaco,
            "Spanish Grand Prix": .barcelona,
            "Canadian Grand Prix": .canada,
            "Austrian Grand Prix": .spielberg,
            "British Grand Prix": .silverstone,
            "Hungarian Grand Prix": .budapest,
            "Belgian Grand Prix": .spa,
            "Dutch Grand Prix": .zandvoort,
            "Italian Grand Prix": .monza,
            "Azerbaijan Grand Prix": .baku,
            "Singapore Grand Prix": .singapore,
            "United States Grand Prix": .austin,
            "Mexico City Grand Prix": .mexico,
            "São Paulo Grand Prix": .brazil,
            "Las Vegas Grand Prix": .vegas,
            "Qatar Grand Prix": .qatar,
            "Abu Dhabi Grand Prix": .abuDhabi
        ]
        return mapping[eventName]
    }

}
