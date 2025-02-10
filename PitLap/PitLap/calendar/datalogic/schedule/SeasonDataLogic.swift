//
//  SeasonCalendarDataLogic.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import SwiftData
import PersistenceManager

protocol SeasonDataLogicType {
    func getSeasonCalendar(for year: String) -> [RaceWeekendEntity]
    func loadSeasons(completion: @escaping (Bool) -> Void) async
    func isDataLoaded() async -> Bool
}

final class SeasonDataLogic: SeasonDataLogicType {
    private let bundle: Bundle
    private let mapper: SeasonEntityMapper

    private let persistenceDataManager: PersistenceDataManager<RaceWeekendEntity>

    init(
        bundle: Bundle = Bundle.main,
        mapper: SeasonEntityMapper = SeasonEntityMapper(),
        persistenceDataManager: PersistenceDataManager<RaceWeekendEntity>
    ) {
        self.persistenceDataManager = persistenceDataManager
        self.mapper = mapper
        self.bundle = bundle
    }

    func fetchRaceWeekend(forRound round: Int) -> RaceWeekendEntity? {
        persistenceDataManager
            .fetchItem(
                predicate: #Predicate<RaceWeekendEntity> { $0.round == round },
                sortDescriptors: [SortDescriptor(\.round)]
            )
    }

    func getSeasonCalendar(for year: String) -> [RaceWeekendEntity] {
        let predicate = #Predicate<RaceWeekendEntity> { $0.year == year }
        return persistenceDataManager.fetchItems(predicate: predicate, sortDescriptors: [SortDescriptor(\.round)])
    }

    func isDataLoaded() async -> Bool {
        let predicate = #Predicate<RaceWeekendEntity> { $0.round == 1 }
        return persistenceDataManager.fetchItem(predicate: predicate) != nil
    }

    func loadSeasons(completion: @escaping (Bool) -> Void) async {
        do {
            let season: SeasonModel = try await bundle.decode("2025.json")
            let previousSeason: SeasonModel = try await bundle.decode("2024.json")
            saveRaceWeekends(items: previousSeason.races, completion: {_ in })
            saveRaceWeekends(items: season.races, completion: completion)
        } catch {
            print("Error loading season calendar: \(error.localizedDescription)")
        }
    }

    func saveRaceWeekends(items: [RaceWeekendModel], completion: @escaping (Bool) -> Void) {
        for item in items {
            let key = "\(item.round)-\(item.year)"
            let predicate = #Predicate<RaceWeekendEntity> { $0.key == key }
            persistenceDataManager.saveIfNotExist(mapToRaceWeekendEntity(from: item), predicate: predicate)
        }
        completion(true)
    }

    private func mapToRaceWeekendEntity(from model: RaceWeekendModel) -> RaceWeekendEntity {
        mapper.mapToRaceWeekendEntity(model)
    }

    private func removePastRaces(from races: [RaceWeekend]) -> [RaceWeekend] {
        let currentDate = Date()
        return races.filter { race in
            guard let raceDate = Date.getDateFromString(dateString: race.sessions.gp) else {
                return false
            }
            return raceDate > currentDate
        }
    }
}
