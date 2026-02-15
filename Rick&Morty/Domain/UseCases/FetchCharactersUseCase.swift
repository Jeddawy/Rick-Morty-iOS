//
//  FetchCharactersUseCase.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

protocol FetchCharactersUseCase {
    func execute(page: Int, name: String?) async throws -> (characters: [CharacterEntity], hasNextPage: Bool)
}

final class FetchCharactersUseCaseDefault: FetchCharactersUseCase {
    private let repository: CharacterRepository

    init(repository: CharacterRepository) {
        self.repository = repository
    }

    func execute(page: Int, name: String?) async throws -> (characters: [CharacterEntity], hasNextPage: Bool) {
        try await repository.fetchCharacters(page: page, name: name)
    }
}
