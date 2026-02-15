//
//  CharacterFilterParameters.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

struct CharacterFilterParameters: Encodable {
    let page: Int
    let name: String?
    
    init(page: Int = 1, 
         name: String? = nil,
         ) {
        self.page = page
        self.name = name
    }
}
