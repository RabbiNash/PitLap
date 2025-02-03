//
//  DriverStandingEntityMapper.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import Foundation
import PersistenceManager

class DriverStandingEntityMapper {
    func mapToDriverStandingEntity(_ standing: DriverStandingModel) -> DriverStandingEntity {
        return DriverStandingEntity(
            position: standing.position,
            positionText: standing.positionText,
            points: standing.points,
            wins: standing.wins,
            driverID: standing.driverID,
            driverNumber: standing.driverNumber,
            driverCode: standing.driverCode,
            driverURL: standing.driverURL,
            givenName: standing.givenName,
            familyName: standing.familyName,
            dateOfBirth: standing.dateOfBirth,
            driverNationality: standing.driverNationality,
            constructorIDS: standing.constructorIDS,
            constructorUrls: standing.constructorUrls,
            constructorNames: standing.constructorNames,
            constructorNationalities: standing.constructorNationalities
        )
    }

    func mapToDriverStandingEntities(_ standings: [DriverStandingModel]) -> [DriverStandingEntity] {
        standings.map(mapToDriverStandingEntity)
    }
}
