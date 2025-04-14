//
//  ApiService.swift
//  PitLap
//
//  Created by Tinashe Makuti on 10/02/2025.
//

import Foundation

// MARK: - API Service Protocol
protocol ApiService {
    func fetchSchedule() async throws -> [RaceWeekendModel]
    func fetchConstructorStandings() async throws -> [ConstructorStandingModel]
    func fetchDriverStandings() async throws -> [DriverStandingModel]
    func fetchDriverTheoreticalStandings() async throws -> [DriverAnalysisModel]
    func fetchRaceSummary(round: Int, year: Int) async throws -> RaceSummaryModel
    func fetchTrackSummary(trackName: String) async throws -> TrackSummaryModel
    func fetchQualiResults(year: Int, round: Int) async throws -> QualiResults
    func fetchPracticeLaps(year: Int, round: Int, sessionName: String) async throws -> PracticeLapsModel
    func fetchWeatherSummary(year: Int, round: Int) async throws -> WeatherModel?
    func fetchYoutubeVideos(channelTitle: String) async throws -> [YoutubeVideoModel]
    func fetchRaceResult(year: Int, round: Int) async throws -> RaceResults
}

final class ApiServiceImpl: ApiService {
    static let shared = ApiServiceImpl()
    
    private let baseURL = "https://pitlap.eu"

    private let cachedSession: URLSession = {
        let cache = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 100 * 1024 * 1024,
            diskPath: "urlCache"
        )

        let config = URLSessionConfiguration.default
        config.urlCache = cache
        config.requestCachePolicy = .useProtocolCachePolicy

        return URLSession(configuration: config)
    }()

    private func fetchData<T: Codable>(route: APIRoute) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(route.path)") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.cachePolicy = .useProtocolCachePolicy

        let (data, response) = try await cachedSession.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        do {
            let decodedResponse = try JSONDecoder().decode(ApiResponse<T>.self, from: data)
            return decodedResponse.data
        } catch {
            throw APIError.decodingFailed(error)
        }
    }

    func fetchSchedule() async throws -> [RaceWeekendModel] {
        return try await fetchData(route: .schedule)
    }

    func fetchDriverStandings() async throws -> [DriverStandingModel] {
        return try await fetchData(route: .driverStandings)
    }

    func fetchConstructorStandings() async throws -> [ConstructorStandingModel] {
        return try await fetchData(route: .constructorStandings)
    }

    func fetchDriverTheoreticalStandings() async throws -> [DriverAnalysisModel] {
        return try await fetchData(route: .driverTheoreticalStandings)
    }

    func fetchRaceSummary(round: Int, year: Int) async throws -> RaceSummaryModel {
        return try await fetchData(route: .raceSummary(year: year, round: round))
    }

    func fetchTrackSummary(trackName: String) async throws -> TrackSummaryModel {
        return try await fetchData(route: .trackSummary(trackName: trackName))
    }
    
    func fetchQualiResults(year: Int, round: Int) async throws -> QualiResults {
        return try await fetchData(route: .qualiResults(year: year, round: round))
    }
    
    func fetchPracticeLaps(year: Int, round: Int, sessionName: String) async throws -> PracticeLapsModel {
        return try await fetchData(route: .laps(year: year, round: round, sessionName: sessionName))
    }
    
    func fetchWeatherSummary(year: Int, round: Int) async throws -> WeatherModel? {
        return try await fetchData(route: .weatherSummary(year: year, round: round))
    }
    
    func fetchYoutubeVideos(channelTitle: String) async throws -> [YoutubeVideoModel] {
        return try await fetchData(route: .youtubeVideos(channelTitle: channelTitle))
    }
    
    func fetchRaceResult(year: Int, round: Int) async throws -> RaceResults {
        return try await fetchData(route: .raceResult(year: year, round: round))
    }
}

// MARK: - API Errors
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed(let error):
            return "Decoding failed: \(error.localizedDescription)"
        }
    }
}
