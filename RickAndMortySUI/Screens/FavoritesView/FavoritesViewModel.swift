//
//  FavoritesViewModel.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 11.03.2025.
//

import SwiftUI

final class FavoritesViewModel: ObservableObject {
    
    @Published var favoritesModel: FavoritesModel = .init()
    @Published var isLoading = false
    @Published var searchText = ""
    
    @Published var selectedSegment = 0
    
    var isEmpty: Bool {
        
        switch selectedSegment {
            
        case 0:
            return favoritesModel.filteredCharacters.isEmpty
            
        case 1:
            return favoritesModel.filteredEpisodes.isEmpty
            
        case 2:
            return favoritesModel.filteredLocations.isEmpty
            
        default:
            return true
        }
    }
    
    var columns: [GridItem] {
        
        switch selectedSegment {
            
        case 0,1:
            return Array(repeating: GridItem(), count: 2)
        default:
            return Array(repeating: GridItem(), count: 1)
        }
    }
    
    init() {
        self.fetchAllFavorites()
    }
    
    func fetchAllFavorites() {
        
        isLoading = true
        
        Task {
            do {
                let favoritesModel = try await NetworkService.shared.getAllFavorites()
                
                await MainActor.run {
                    self.favoritesModel = favoritesModel
                    filterFavorites()
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
    
    func filterFavorites() {
        
        favoritesModel.filteredCharacters = searchText.isEmpty ? favoritesModel.characters : favoritesModel.characters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        
        favoritesModel.filteredEpisodes = searchText.isEmpty ? favoritesModel.episodes : favoritesModel.episodes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        
        favoritesModel.filteredLocations = searchText.isEmpty ? favoritesModel.locations : favoritesModel.locations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
