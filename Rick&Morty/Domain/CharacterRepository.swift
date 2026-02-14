//
//  CharacterRepository.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

protocol CharacterRepository {
    func fetchCharacters(page: Int, name: String?) async throws -> (characters: [CharacterModel], hasNextPage: Bool)
}
