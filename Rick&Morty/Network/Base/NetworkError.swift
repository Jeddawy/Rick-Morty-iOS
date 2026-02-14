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
            return "Invalid request URL."
        case .invalidResponse:
            return "Invalid server response."
        case .httpError(_, let message):
            return message ?? "Server returned an error."
        case .decodingError:
            return "Failed to decode response."
        case .encodingError:
            return "Failed to encode request."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
