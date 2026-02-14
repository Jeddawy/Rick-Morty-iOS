//
//  NetworkErrorTests.swift
//  Rick&MortyTests
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Testing
import Foundation
@testable import Rick_Morty

struct NetworkErrorTests {
    
    @Test func testInvalidURLMessage() {
        let error = NetworkError.invalidURL
        #expect(error.message == AppStrings.Network.invalidURL)
    }
    
    @Test func testInvalidResponseMessage() {
        let error = NetworkError.invalidResponse
        #expect(error.message == AppStrings.Network.invalidResponse)
    }
    
    @Test func testHTTPErrorMessageFromBackend() {
        let message = "Backend error"
        let error = NetworkError.httpError(statusCode: 400, message: message)
        #expect(error.message == message)
    }
    
    @Test func testHTTPError404() {
        // nil message, so should fallback to statusCode check
        let error = NetworkError.httpError(statusCode: 404, message: nil)
        #expect(error.message == AppStrings.noCharactersFound)
    }
    
    @Test func testHTTPErrorUnknown() {
        let error = NetworkError.httpError(statusCode: 500, message: nil)
        #expect(error.message == AppStrings.Network.unknownError)
    }
    
    @Test func testDecodingErrorMessage() {
        let error = NetworkError.decodingError(NSError(domain: "", code: 0))
        #expect(error.message == AppStrings.Network.decodingError)
    }
    
    @Test func testEncodingErrorMessage() {
        let error = NetworkError.encodingError(NSError(domain: "", code: 0))
        #expect(error.message == AppStrings.Network.encodingError)
    }
    
    @Test func testUnknownErrorMessage() {
        let error = NetworkError.unknown(NSError(domain: "", code: 0))
        #expect(error.message == AppStrings.Network.unknownError)
    }
}
