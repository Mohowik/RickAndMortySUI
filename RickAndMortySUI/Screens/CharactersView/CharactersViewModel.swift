//
//  CharactersViewModel.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 08.03.2025.
//

import Foundation

final class CharactersViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var isLoading = false
    
    private var page: Int = 1
    private var limit: Int = 1
    
    init() {
        self.fetchCharacters()
    }
    
    func fetchCharacters() {
        
        guard !isLoading,
              page <= limit else { return }
        isLoading = true
        Task {
            do {
                let model = try await NetworkService.shared.getAllCharacters(page: page)
                
                await MainActor.run {
                    
                    characters.append(contentsOf: model.characters)
                    setActualFavoriteStatus()
                    limit = model.info.pages
                    page += 1
                    isLoading = false
                }
            } catch {
                
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
    
    func setActualFavoriteStatus() {
        
        let favoritesIDs = UserDefaultsManager.shared.fetchFavoritesIds(for: StringValue.charactersKey)
        characters.enumerated().forEach { index, character in
            var character = character
            character.isFavorite = favoritesIDs.first(where: { $0 == character.id }) != nil
            characters[index] = character
        }
    }
}
