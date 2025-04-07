//
//  SeasonEntityMapper.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 17/01/2025.
//

import Foundation
import PersistenceManager

class SeasonEntityMapper {
    func mapToRaceWeekendEntity(_ weekend: RaceWeekendModel) -> RaceWeekendEntity {
        return RaceWeekendEntity(
            uuid: weekend.id,
            round: weekend.round,
            country: weekend.country,
            officialEventName: weekend.officialEventName,
            eventName: weekend.eventName,
            eventFormat: weekend.eventFormat,
            session1: weekend.session1,
            session1DateUTC: weekend.session1DateUTC ?? "",
            session2: weekend.session2,
            session2DateUTC: weekend.session2DateUTC ?? "",
            session3: weekend.session3,
            session3DateUTC: weekend.session3DateUTC ?? "",
            session4: weekend.session4,
            session4DateUTC: weekend.session4DateUTC ?? "",
            session5: weekend.session5,
            session5DateUTC: weekend.session5DateUTC ?? "",
            year: weekend.year
        )
    }
}
