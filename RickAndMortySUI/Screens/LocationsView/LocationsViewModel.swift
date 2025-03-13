//
//  LocationsViewModel.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 11.03.2025.
//

import Foundation

final class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location] = []
    @Published var isLoading = false
    
    private var page: Int = 1
    private var limit: Int = 1
    
    init() {
        self.fetchLocations()
    }
    
    func fetchLocations() {
        
        guard !isLoading,
              page <= limit else { return }
        isLoading = true
        Task {
            do {
                let model = try await NetworkService.shared.getAllLocations(page: page)
                
                await MainActor.run {
                    
                    locations.append(contentsOf: model.locations)
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
        
        let favoritesIDs = UserDefaultsManager.shared.fetchFavoritesIds(for: StringValue.locationsKey)
        locations.enumerated().forEach { index, location in
            var location = location
            location.isFavorite = favoritesIDs.first(where: { $0 == location.id }) != nil
            locations[index] = location
        }
    }
}
