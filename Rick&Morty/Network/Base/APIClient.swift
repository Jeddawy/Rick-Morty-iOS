//
//  APIClient.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

// MARK: - HTTP Methods
enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", patch = "PATCH", delete = "DELETE"
}

// MARK: - Parameter Encoding
enum ParameterEncoding {
    case query
    case json
}

// MARK: - API Endpoint Protocol
protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: Encodable? { get }
    var pathParameters: [String: String]? { get }
    var encoding: ParameterEncoding { get }
}

extension APIEndpoint {
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return .query
        default:
            return .json
        }
    }
    
    var pathParameters: [String: String]? { nil }
}

// MARK: - API Client Protocol
protocol APIClient {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}
