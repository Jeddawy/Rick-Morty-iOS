//
//  CharactersView.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import SwiftUI

struct CharactersView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
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
