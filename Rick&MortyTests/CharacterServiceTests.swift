//
//  CharacterServiceTests.swift
//  Rick&MortyTests
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Testing
import Foundation

struct CharacterServiceTests {
    
    @Test func testGetCharactersSuccess() async throws {
        let mockClient = MockAPIClient()
        let service = CharacterService(client: mockClient)
        
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
            info: .init(count: 1, pages: 1, next: nil, prev: nil),
            results: [mockCharacter]
        )
        
        mockClient.result = .success(mockResponse)
        
        let result = try await service.getCharacters(parameters: .init(page: 1, name: nil))
        
        switch result {
        case .success(let response):
            #expect(response.results?.count == 1)
            #expect(response.results?.first?.name == "Rick")
        case .failure:
            Issue.record("Expected success but got failure")
        }
    }
    
    @Test func testGetCharactersFailure() async throws {
        let mockClient = MockAPIClient()
        let service = CharacterService(client: mockClient)
        
        mockClient.result = .failure(NetworkError.invalidResponse)
        
        let result = try await service.getCharacters(parameters: .init(page: 1, name: nil))
        
        switch result {
        case .success:
            Issue.record("Expected failure but got success")
        case .failure(let error):
            #expect(error is NetworkError)
        }
    }
}
