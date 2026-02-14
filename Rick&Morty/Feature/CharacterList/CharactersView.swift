//
//  CharactersView.swift
//  Rick&Morty
//
//  Created by Ibrahim El-geddawy on 14/02/2026.
//

import SwiftUI

struct CharactersView: View {
    
    @StateObject private var viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            contentSection
            .listStyle(.plain)
            .searchable(text:$viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: AppStrings.searchPrompt)
            .navigationDestination(for: CharacterModel.self) { character in
                CharacterDetailView(character: character)
            }
        }
    }
    
    @ViewBuilder
    private var contentSection: some View {
        switch viewModel.stateConfiguration {
        case .idle:
            Color.clear.task {
                viewModel.loadCharacters()
            }
            
        case .loading:
            VStack {
                Spacer()
                ProgressView(AppStrings.loading)
                Spacer()
            }
            
        case .noNetwork:
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: AppImages.wifiSlash)
                    .font(.system(size: 60))
                    .foregroundColor(.gray)
                Text(AppStrings.noInternetMatches)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(AppStrings.checkConnection)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Button(AppStrings.retry) {
                    viewModel.loadCharacters()
                }
                .buttonStyle(.bordered)
                Spacer()
            }
            
        case .noSearchResults:
            VStack {
                Spacer()
                Image(systemName: AppImages.magnifyingGlass)
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                Text(AppStrings.noCharactersFound)
                    .foregroundColor(.secondary)
                    .padding()
                Spacer()
            }
            
        case .failedToLoad(let message):
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: AppImages.warning)
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                Text(message)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Button(AppStrings.retry) {
                    viewModel.loadCharacters()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            
        case .loaded(let characters):
            List {
                ForEach(characters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        CharacterRowView(character: character)
                            .task {
                                viewModel.loadMoreIfNeeded(currentItem: character)
                            }
                    }
                }
                
                if viewModel.hasNextPage {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    CharactersView(viewModel: DIContainer().makeCharactersViewModel())
}
