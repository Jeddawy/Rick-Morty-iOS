//
//  DIContainer.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

final class DIContainer {
    
    // MARK: - Services
    private let apiClient: APIClient
    private let characterService: CharacterServiceable
    
    // MARK: - Repositories
    private let characterRepository: CharacterRepository
    
    init() {
        self.apiClient = URLSessionAPIClient()
        self.characterService = CharacterService(client: apiClient)
        self.characterRepository = CharacterRepositoryDefault(service: characterService)
    }
    
    // MARK: - Factories
    
    func makeCharactersViewModel() -> CharactersViewModel {
        return CharactersViewModel(repository: characterRepository)
    }
}
