//
//  CharacterServiceable.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//


import Foundation

protocol CharacterServiceable {
    func getCharacters(parameters: CharacterFilterParameters) async throws -> Result<RickAndMortyResponse<[CharacterResponse]>, Error>
}

struct CharacterService: CharacterServiceable {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func getCharacters(parameters: CharacterFilterParameters) async throws -> Result<RickAndMortyResponse<[CharacterResponse]>, Error> {
        let endpoint = CharacterEndpoint.characters(parameters)
        
        do {
            let response: RickAndMortyResponse<[CharacterResponse]> = try await client.request(endpoint)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
