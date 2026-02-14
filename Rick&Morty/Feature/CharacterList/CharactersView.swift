//
//  CharactersView.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import SwiftUI

struct CharactersView: View {
    private var mock: MockData = MockData()
    @State private var searchText: String = ""

    var filteredCharacters: [CharacterModel] {
        if searchText.isEmpty {
            return MockData.characters
        } else {
            return MockData.characters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCharacters) { character in
                    CharacterRowView(character: character)
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search characters...")
        }
        .task {
            do {
                let service = CharacterService()
                let result = try await service.getCharacters(parameters: CharacterFilterParameters())
                print(result)
            } catch {
                print("Error fetching characters: \(error)")
            }
        }
    }
}

#Preview {
    CharactersView()
}
