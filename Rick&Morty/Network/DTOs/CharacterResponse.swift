//
//  CharacterResponse.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

struct CharacterResponse: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: LocationResponse
    
    struct LocationResponse: Decodable {
        let name: String
        let url: String
    }
}
