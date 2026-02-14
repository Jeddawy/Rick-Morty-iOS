//
//  CharacterModel.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//


import Foundation

struct CharacterModel: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: String
    let imageUrl: String
    let location: LocationModel
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, gender, location
        case imageUrl = "image"
    }
}

struct LocationModel: Codable, Hashable {
    var name: String
    var url: String
}

enum CharacterStatus: String, Codable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
