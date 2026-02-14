//
//  AppConstants.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

enum AppStrings {
    static let searchPrompt = "Search characters..."
    static let loading = "Loading..."
    static let noInternetMatches = "No Internet Connection"
    static let checkConnection = "Please check your connection and try again."
    static let retry = "Retry"
    static let noCharactersFound = "No characters found"
    
    enum Network {
        static let invalidURL = "Invalid request URL."
        static let invalidResponse = "Invalid server response."
        static let serverErrorDefault = "Server returned an error."
        static let decodingError = "Failed to decode response."
        static let encodingError = "Failed to encode request."
    }
}

enum AppImages {
    static let wifiSlash = "wifi.slash"
    static let magnifyingGlass = "magnifyingglass"
    static let warning = "exclamationmark.triangle"
    static let personFill = "person.fill"
}
