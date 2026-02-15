//
//  CharacterEntity.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

struct CharacterEntity: Identifiable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: String
    let imageUrl: String
    let location: LocationEntity
}

struct LocationEntity: Hashable {
    var name: String
    var url: String
}

enum CharacterStatus: String, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
