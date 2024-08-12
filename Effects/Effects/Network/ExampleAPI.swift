//
//  ExampleAPI.swift
//  Effects
//
//  Created by Anton Gorlov on 05.08.2024.
//

import Foundation
import Combine

struct ExampleAPI {
    func getCharacters(_ url: URL) -> AnyPublisher<[PersonResponseData], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .tryMap { data in try JSONDecoder().decode(CharactersResultsResponseData.self, from: data) }
            .map { $0.results }
            .eraseToAnyPublisher()
         
    }
    
    func getAsync(_ url: URL) async throws -> [PersonResponseData] {
        let result = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(CharactersResultsResponseData.self, from: result.0)
        return response.results
    }
}
