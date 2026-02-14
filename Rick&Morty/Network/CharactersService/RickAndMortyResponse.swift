//
//  RickAndMortyResponse.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//


import Foundation

struct RickAndMortyResponse<T: Decodable>: Decodable {
    let info: Info
    let results: T
    
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
