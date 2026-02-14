//
//  CharacterServiceable.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//


import Foundation

protocol CharacterServiceable {
    func getCharacters(parameters: CharacterFilterParameters) async throws -> Result<RickAndMortyResponse<[CharacterModel]>, Error>
}

struct CharacterService: CharacterServiceable {
    private let client: APIClient
    
    init(client: APIClient = URLSessionAPIClient()) {
        self.client = client
    }
    
    func getCharacters(parameters: CharacterFilterParameters) async throws -> Result<RickAndMortyResponse<[CharacterModel]>, Error> {
        let endpoint = CharacterEndpoint.characters(parameters)
        
        do {
            let response: RickAndMortyResponse<[CharacterModel]> = try await client.request(endpoint)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
