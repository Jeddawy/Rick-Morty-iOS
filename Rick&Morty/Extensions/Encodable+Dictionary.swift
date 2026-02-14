//
//  Encodable+Dictionary.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation


// MARK: - Helper to convert Encodable to [String: String]
extension Encodable {
    func asDictionary() throws -> [String: String] {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        guard let dict = jsonObject as? [String: Any] else {
            return [:]
        }
        var stringDict: [String: String] = [:]
        for (key, value) in dict {
            if !(value is NSNull) {
                stringDict[key] = "\(value)"
            }
        }
        return stringDict
    }
}
