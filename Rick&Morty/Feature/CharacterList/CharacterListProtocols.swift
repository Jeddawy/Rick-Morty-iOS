//
//  CharactersConfigurations.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import Foundation

typealias CharacterListViewModel = ListDisplayable & ListInteractable

protocol ListDisplayable: ObservableObject {
    var searchText: String { get set }
    var stateConfiguration: CharacterListState { get set }
    var hasNextPage: Bool { get }
}

enum CharacterListState: Equatable {
    case idle
    case noNetwork
    case loading
    case loaded([CharacterEntity])
    case failedToLoad(_ msg: String)
}

protocol ListInteractable: ObservableObject {
    func loadMoreIfNeeded(currentItem: CharacterEntity)
}
