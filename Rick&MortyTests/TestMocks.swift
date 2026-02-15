//
//  TestMocks.swift
//  Rick&MortyTests
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation
import Testing

// MARK: - MockAPIClient
class MockAPIClient: APIClient {
    var result: Result<Any, Error>?
    var requestedEndpoint: APIEndpoint?
    
    func request<T>(_ endpoint: APIEndpoint) async throws -> T where T : Decodable {
        requestedEndpoint = endpoint
        
        guard let result = result else {
            fatalError("Result not set in MockAPIClient")
        }
        
        switch result {
        case .success(let data):
            guard let castedData = data as? T else {
                fatalError("Failed to cast mock data to \(T.self)")
            }
            return castedData
        case .failure(let error):
            throw error
        }
    }
}

// MARK: - MockCharacterService
class MockCharacterService: CharacterServiceable {
    var result: Result<RickAndMortyResponse<[CharacterResponse]>, Error>?
    
    func getCharacters(parameters: CharacterFilterParameters) async throws -> Result<RickAndMortyResponse<[CharacterResponse]>, Error> {
        guard let result = result else {
            fatalError("Result not set in MockCharacterService")
        }
        return result
    }
}

// MARK: - MockCharacterRepository
class MockCharacterRepository: CharacterRepository {
    var fetchCharactersResult: Result<(characters: [CharacterEntity], hasNextPage: Bool), Error>?
    
    func fetchCharacters(page: Int, name: String?) async throws -> (characters: [CharacterEntity], hasNextPage: Bool) {
        guard let result = fetchCharactersResult else {
            fatalError("Result not set in MockCharacterRepository")
        }
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
