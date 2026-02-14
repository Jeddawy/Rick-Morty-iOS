//
//  NetworkError.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

// MARK: - Network Error
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, message: String?)
    case decodingError(Error)
    case encodingError(Error)
    case unknown(Error)
}

extension NetworkError {
    var message: String {
        switch self {
        case .invalidURL:
            return AppStrings.Network.invalidURL
        case .invalidResponse:
            return AppStrings.Network.invalidResponse
        case .httpError(_, let message):
            return message ?? AppStrings.Network.serverErrorDefault
        case .decodingError:
            return AppStrings.Network.decodingError
        case .encodingError:
            return AppStrings.Network.encodingError
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
