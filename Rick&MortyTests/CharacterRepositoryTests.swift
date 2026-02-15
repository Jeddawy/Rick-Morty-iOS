//
//  CharacterRepositoryTests.swift
//  Rick&MortyTests
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Testing
import Foundation

struct CharacterRepositoryTests {
    
    @Test func testFetchCharactersSuccess() async throws {
        let mockService = MockCharacterService()
        let repository = CharacterRepositoryDefault(service: mockService)
        
        let mockCharacter = CharacterResponse(
            id: 1,
            name: "Rick",
            status: "Alive",
            species: "Human",
            gender: "Male",
            image: "url",
            location: .init(name: "Earth", url: "url")
        )
        
        let mockResponse = RickAndMortyResponse(
            info: .init(count: 1, pages: 1, next: "next_url", prev: nil),
            results: [mockCharacter]
        )
        
        mockService.result = .success(mockResponse)
        
        let (characters, hasNextPage) = try await repository.fetchCharacters(page: 1, name: nil)
        
        #expect(characters.count == 1)
        #expect(characters.first?.name == "Rick")
        #expect(characters.first?.location.name == "Earth")
        #expect(hasNextPage == true)
    }
    
    @Test func testFetchCharactersFailure() async throws {
        let mockService = MockCharacterService()
        let repository = CharacterRepositoryDefault(service: mockService)
        
        mockService.result = .failure(NetworkError.invalidResponse)
        
        await #expect(throws: NetworkError.self) {
            try await repository.fetchCharacters(page: 1, name: nil)
        }
    }
    
//    @Test func testFetchCharactersPagination() async throws {
//        let mockService = MockCharacterService()
//        let repository = CharacterRepositoryDefault(service: mockService)
//        
//        // Test no next page
//        let mockResponseNoNext = RickAndMortyResponse(
//            info: .init(count: 1, pages: 1, next: nil, prev: nil),
//            results: []
//        )
//        mockService.result = .success(mockResponseNoNext)
//        
//        let (_, hasNextPage) = try await repository.fetchCharacters(page: 1, name: nil)
//        #expect(hasNextPage == false)
//    }
}
