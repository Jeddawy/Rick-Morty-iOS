//
//  CharacterRepositoryDefault.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//


import Foundation

class CharacterRepositoryDefault: CharacterRepository {
    private let service: CharacterServiceable
    
    init(service: CharacterServiceable) {
        self.service = service
    }
    
    func fetchCharacters(page: Int, name: String?) async throws -> (characters: [CharacterEntity], hasNextPage: Bool) {
        let params = CharacterFilterParameters(page: page, name: name)
        let result = try await service.getCharacters(parameters: params)
        
        switch result {
        case .success(let response):
            let entities = (response.results ?? []).map { $0.toEntity() }
            return (characters: entities, hasNextPage: response.info?.next != nil)
        case .failure(let error):
            throw error
        }
    }
}

private extension CharacterResponse {
    func toEntity() -> CharacterEntity {
        CharacterEntity(
            id: id ?? 0,
            name: name ?? "",
            status: CharacterStatus(rawValue: status ?? "") ?? .unknown,
            species: species ?? "",
            gender: gender ?? "",
            imageUrl: image ?? "",
            location: LocationEntity(
                name: location?.name ?? "",
                url: location?.url ?? ""
            )
        )
    }
}
