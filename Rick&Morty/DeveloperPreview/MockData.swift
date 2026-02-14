//
//  MockData.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

struct MockData {
    static let rick = CharacterModel(
        id: 1,
        name: "Rick Sanchez",
        status: .alive,
        species: "Human",
        gender: "Male",
        imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        location: LocationModel(name: "Citadel of Ricks", url: "")
    )
    
    static let morty = CharacterModel(
        id: 2,
        name: "Morty Smith",
        status: .alive,
        species: "Human",
        gender: "Male",
        imageUrl: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        location: LocationModel(name: "Earth (C-137)", url: "")
    )
    
    static let summer = CharacterModel(
        id: 3,
        name: "Summer Smith",
        status: .alive,
        species: "Human",
        gender: "Female",
        imageUrl: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
        location: LocationModel(name: "Earth (C-137)", url: "")
    )
    
    static let characters = [rick, morty, summer]
}
