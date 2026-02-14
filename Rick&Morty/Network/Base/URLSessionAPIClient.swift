//
//  URLSessionAPIClient.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

// MARK: - Network Client
final class URLSessionAPIClient: APIClient {
    
    private let session: URLSession
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder
    private let logger: ((String) -> Void)?
    
    init(session: URLSession = .shared,
         jsonEncoder: JSONEncoder = JSONEncoder(),
         jsonDecoder: JSONDecoder = JSONDecoder(),
         logger: ((String) -> Void)? = { print($0) }) { // default prints to console
        self.session = session
        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder
        self.logger = logger
    }
    
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        let url = try buildURL(for: endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        // Add headers
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        // Encode body if needed
        if endpoint.encoding == .json, let parameters = endpoint.parameters {
            do {
                request.httpBody = try jsonEncoder.encode(parameters)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw NetworkError.encodingError(error)
            }
        }
        
        // Log request
        logRequest(request)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            // Log response
            logResponse(response: response, data: data)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                let message = try? JSONDecoder().decode(ServerErrorResponse.self, from: data).error
                throw NetworkError.httpError(statusCode: httpResponse.statusCode, message: message)
            }
            
            do {
                return try jsonDecoder.decode(T.self, from: data)
            } catch {
                logger?("❌ Decoding error: \(error)")
                throw NetworkError.decodingError(error)
            }
            
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
    
    // MARK: - Logging Helpers
    private func logRequest(_ request: URLRequest) {
        var log = "\n➡️ REQUEST: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")\n"
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            log += "Headers:\n"
            headers.forEach { log += "  \($0.key): \($0.value)\n" }
        }
        
        if let body = request.httpBody, let str = String(data: body, encoding: .utf8) {
            log += "Body:\n\(str)\n"
        }
        
        logger?(log)
    }
    
    private func logResponse(response: URLResponse?, data: Data) {
        guard let httpResponse = response as? HTTPURLResponse else {
            logger?("❌ Response is not HTTPURLResponse")
            return
        }
        
        var log = "\n⬅️ RESPONSE: \(httpResponse.statusCode) \(httpResponse.url?.absoluteString ?? "")\n"
        
        if !httpResponse.allHeaderFields.isEmpty {
            log += "Headers:\n"
            httpResponse.allHeaderFields.forEach { log += "  \($0.key): \($0.value)\n" }
        }
        
        if let bodyString = String(data: data, encoding: .utf8) {
            log += "Body:\n\(bodyString)\n"
        }
        
        logger?(log)
    }
    
    // MARK: - URL Builder
    private func buildURL(for endpoint: APIEndpoint) throws -> URL {
        guard var components = URLComponents(string: endpoint.baseURL) else {
            throw NetworkError.invalidURL
        }
        
        var path = endpoint.path
        if let pathParams = endpoint.pathParameters {
            for (key, value) in pathParams {
                path = path.replacingOccurrences(of: "{\(key)}", with: value)
            }
        }
        components.path = components.path.hasSuffix("/") ? components.path + path : components.path + "/" + path
        
        // Query parameters
        if endpoint.encoding == .query, let parameters = endpoint.parameters {
            let dict = try parameters.asDictionary()
            components.queryItems = dict.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
}

// MARK: - Server Error Response
struct ServerErrorResponse: Decodable {
    let error: String
}
