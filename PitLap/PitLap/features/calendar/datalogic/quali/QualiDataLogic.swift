//
//  QualiDataLogic.swift
//  PitLap
//
//  Created by Tinashe Makuti on 13/02/2025.
//

protocol QualiDataLogicType {
    func getQualiResults(year: Int, round: Int) async -> [QualiResultModel]
}

final class QualiDataLogic: QualiDataLogicType {
    
    private let apiService: ApiService
    
    init(apiService: ApiService = ApiServiceImpl.shared) {
        self.apiService = apiService
    }
    
    func getQualiResults(year: Int, round: Int) async -> [QualiResultModel] {
        do {
            return try await apiService.fetchQualiResults(year: year, round: round).results
        } catch {
            print("Error loading race summary \(error.localizedDescription)")
        }
        return []
    }
}
