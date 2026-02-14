//
//  Rick_MortyApp.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import SwiftUI

@main
struct Rick_MortyApp: App {
    private let container = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            CharactersView(viewModel: container.makeCharactersViewModel())
        }
    }
}
