//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//


import Foundation
import Combine

class CharactersViewModel: CharacterListViewModel {
    
    // MARK: - ListDisplayable Properties
    @Published var stateConfiguration: CharacterListState = .idle
    @Published var searchText: String = ""
    @Published var hasNextPage: Bool = false
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var currentCharacters: [CharacterModel] = []
    private var searchTask: Task<Void, Never>?

    private let repository: CharacterRepository

    init(repository: CharacterRepository) {
        self.repository = repository
        setupBinding()
    }
    
    // MARK: - ListInteractable Methods

    func loadMoreIfNeeded(currentItem: CharacterModel) {
        guard case .loaded(let characters) = stateConfiguration else { return }
        guard hasNextPage && !isLoading && currentItem.id == characters.last?.id else { return }
        
        currentPage += 1
        Task { await fetchCharacters(page: currentPage, name: searchText.isEmpty ? nil : searchText) }
    }
    
    // MARK: - Private Helpers
    
    private var isLoading: Bool {
        if case .loading = stateConfiguration { return true }
        return false
    }
    
    func loadCharacters() {
        currentPage = 1
        hasNextPage = true
        Task {
            await fetchCharacters(page: currentPage, name: searchText.isEmpty ? nil : searchText)
        }
    }
}

//MARK: private helpers

private extension CharactersViewModel {
    
    func fetchCharacters(page: Int, name: String?) async {
        
        if page == 1 {
            stateConfiguration = .loading
        }
        
        do {
            if Task.isCancelled { return }
            
            let (newCharacters, hasNext) = try await repository.fetchCharacters(page: page, name: name)
            
            if Task.isCancelled { return }
            
            if page == 1 {
                self.currentCharacters = newCharacters
            } else {
                self.currentCharacters.append(contentsOf: newCharacters)
            }
            
            self.hasNextPage = hasNext
            
            if self.currentCharacters.isEmpty {
                self.stateConfiguration = .noSearchResults
            } else {
                self.stateConfiguration = .loaded(self.currentCharacters)
            }
            
        } catch let error as NetworkError {
            if Task.isCancelled { return }
            self.stateConfiguration = .failedToLoad(error.localizedDescription)
        } catch {
            if Task.isCancelled { return }
            self.stateConfiguration = .failedToLoad(error.localizedDescription)
        }
    }
    
    private func search(query: String) {
        searchTask?.cancel()

        currentPage = 1
        hasNextPage = true
        
        searchTask = Task {
            await fetchCharacters(page: currentPage, name: query.isEmpty ? nil : query)
        }
    }
    
    func setupBinding() {
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.search(query: query)
            }
            .store(in: &cancellables)
    }
}
