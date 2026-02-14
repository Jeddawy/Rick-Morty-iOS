//
//  URLSessionAPIClientTests.swift
//  Rick&MortyTests
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Testing
import Foundation
@testable import Rick_Morty

struct URLSessionAPIClientTests {
    
    // MARK: - Mocks
    
    struct MockEndpoint: APIEndpoint {
        var baseURL: String
        var path: String
        var method: HTTPMethod
        var headers: [String : String]?
        var parameters: Encodable?
        var pathParameters: [String : String]?
        var encoding: ParameterEncoding
    }
    
    // MockURLProtocol to intercept requests
    class MockURLProtocol: URLProtocol {
        static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
        
        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            guard let handler = MockURLProtocol.requestHandler else {
                fatalError("Handler not set")
            }
            
            do {
                let (response, data) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }
        
        override func stopLoading() {}
    }
    
    // MARK: - Tests
    
    @Test func testURLBuildingWithQueryParameters() async throws {
        // Setup configuration to use MockURLProtocol
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        
        let client = URLSessionAPIClient(session: session)
        
        // Define expectation
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url,
                  let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                fatalError("Invalid URL")
            }
            
            #expect(url.path == "/api/test")
            #expect(components.queryItems?.contains(URLQueryItem(name: "key", value: "value")) == true)
            #expect(request.httpMethod == "GET")
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = try! JSONEncoder().encode(["success": true])
            return (response, data)
        }
        
        // Define endpoint
        struct Params: Encodable { let key: String }
        let endpoint = MockEndpoint(
            baseURL: "https://example.com",
            path: "api/test",
            method: .get,
            headers: nil,
            parameters: Params(key: "value"),
            pathParameters: nil,
            encoding: .query
        )
        
        // Execute request
        let _: [String: Bool] = try await client.request(endpoint)
    }
    
    @Test func testURLBuildingWithPathParameters() async throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let client = URLSessionAPIClient(session: session)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else { fatalError("Invalid URL") }
            
            #expect(url.path == "/api/user/123/details")
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = try! JSONEncoder().encode(["success": true])
            return (response, data)
        }
        
        let endpoint = MockEndpoint(
            baseURL: "https://example.com",
            path: "api/user/{id}/details",
            method: .get,
            headers: nil,
            parameters: nil,
            pathParameters: ["id": "123"],
            encoding: .query
        )
        
        let _: [String: Bool] = try await client.request(endpoint)
    }
    
    @Test func testRequestEncodingJSON() async throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let client = URLSessionAPIClient(session: session)
        
        MockURLProtocol.requestHandler = { request in
            #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
            
            if let body = request.httpBody,
               let json = try? JSONSerialization.jsonObject(with: body, options: []) as? [String: String] {
                #expect(json["key"] == "value")
            } else {
                Issue.record("Body missing or invalid")
            }
            
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let data = try! JSONEncoder().encode(["success": true])
            return (response, data)
        }
        
        struct Params: Encodable { let key: String }
        let endpoint = MockEndpoint(
            baseURL: "https://example.com",
            path: "api/post",
            method: .post,
            headers: nil,
            parameters: Params(key: "value"),
            pathParameters: nil,
            encoding: .json
        )
        
        let _: [String: Bool] = try await client.request(endpoint)
    }
}
