//
//  CharacterEndpoint.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

enum CharacterEndpoint: APIEndpoint {
    
    case characters(CharacterFilterParameters)
    
    //TODO : make  add it to configfile
    var baseURL: String {
        "https://rickandmortyapi.com/"
    }
    
    var path: String {
        switch self {
        case .characters:
            return "api/character"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .characters:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        .query
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: Encodable? {
        switch self {
        case .characters(let params):
            return params
        default:
            return nil
        }
    }
}
