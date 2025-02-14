//
//  LapDataMapper.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

import Foundation

protocol LapDataMapperType {
    func mapToGroupedLapModels(laps: [LapModel]) -> [GroupedLapModel]
}

class LapDataMapper: LapDataMapperType {
    func mapToGroupedLapModels(laps: [LapModel]) -> [GroupedLapModel] {
        let groupedByDriver = Dictionary(grouping: laps) { $0.driver }
        
        return groupedByDriver.map { driver, driverLaps in
            GroupedLapModel(
                driver: driver,
                fullName: driverLaps.first?.fullName ?? "",
                headshotUrl: driverLaps.first?.headshotUrl ?? "",
                compoundLaps: groupLapsByCompound(laps: driverLaps),
                bestLapTime: findBestLapTime(laps: driverLaps)
            )
        }.sorted { $0.bestLapTime < $1.bestLapTime }
    }
    
    private func groupLapsByCompound(laps: [LapModel]) -> [CompoundLaps] {
        let groupedDict = Dictionary(grouping: laps) { $0.compound }
        return groupedDict.map { CompoundLaps(compound: $0.key, laps: $0.value) }
    }
    
    private func findBestLapTime(laps: [LapModel]) -> String {
        return laps.min { $0.lapTime < $1.lapTime }?.lapTime ?? ""
    }
}

