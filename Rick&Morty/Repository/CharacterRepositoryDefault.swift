//
//  CharacterRepositoryDefault.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//


import Foundation

class CharacterRepositoryDefault: CharacterRepository {
    private let service: CharacterServiceable
    
    init(service: CharacterServiceable = CharacterService()) {
        self.service = service
    }
    
    func fetchCharacters(page: Int, name: String?) async throws -> (characters: [CharacterModel], hasNextPage: Bool) {
        let params = CharacterFilterParameters(page: page, name: name)
        let result = try await service.getCharacters(parameters: params)
        
        switch result {
        case .success(let response):
            return (characters: response.results, hasNextPage: response.info.next != nil)
        case .failure(let error):
            throw error
        }
    }
}
