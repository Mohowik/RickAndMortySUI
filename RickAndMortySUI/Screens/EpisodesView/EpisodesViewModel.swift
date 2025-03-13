//
//  EpisodesViewModel.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import Foundation

final class EpisodesViewModel: ObservableObject {
    
    @Published var episodes: [Episode] = []
    @Published var isLoading = false
    
    private var page: Int = 1
    private var limit: Int = 1
    
    init() {
        self.fetchEpisodes()
    }
    
    func fetchEpisodes() {
        
        guard !isLoading,
              page <= limit else { return }
        isLoading = true
        Task {
            do {
                let model = try await NetworkService.shared.getAllEpisodes(page: page)
                
                await MainActor.run {
                    
                    episodes.append(contentsOf: model.episodes)
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
        
        let favoritesIDs = UserDefaultsManager.shared.fetchFavoritesIds(for: StringValue.episodesKey)
        episodes.enumerated().forEach { index, episode in
            var episode = episode
            episode.isFavorite = favoritesIDs.first(where: { $0 == episode.id }) != nil
            episodes[index] = episode
        }
    }
}
