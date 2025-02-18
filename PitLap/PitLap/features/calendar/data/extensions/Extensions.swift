//
//  Extensions.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 30/12/2024.
//

import Foundation
import SwiftData

extension Bundle {
    func decode<T: Codable>(_ file: String) async throws -> T {
        // 1. Locate the JSON file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw NSError(domain: "BundleError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Failed to locate \(file) in bundle"])
        }

        // 2. Load the data asynchronously
        let data = try await Task { () -> Data in
            try Data(contentsOf: url)
        }.value

        // 3. Decode the JSON data
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NSError(domain: "DecodingError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to decode \(file) from bundle error is \(error)"])
        }
    }
}
