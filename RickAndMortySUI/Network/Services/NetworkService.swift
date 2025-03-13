//
//  NetworkService.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 08.03.2025.
//

import Foundation
import Alamofire

final class NetworkService: Sendable {
    
    static let shared: NetworkService = .init()
    
    private init() { }
    
    func getAllCharacters(page: Int) async throws -> CharactersResponseModel {
        
        try await withCheckedThrowingContinuation { continuation in
            
            let url = "https://rickandmortyapi.com/api/character?page=\(page)"
            
            AF.request(url,
                       method: .get)
            .responseDecodable(of: CharactersResponseModel.self) { response in
                
                switch response.result {
                case .success(let model):
                    continuation.resume(returning: model)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getAllEpisodes(page: Int) async throws -> EpisodesResponseModel {
        
        try await withCheckedThrowingContinuation { continuation in
            
            let url = "https://rickandmortyapi.com/api/episode?page=\(page)"
            
            AF.request(url,
                       method: .get)
            .responseDecodable(of: EpisodesResponseModel.self) { response in
                
                switch response.result {
                case .success(let model):
                    continuation.resume(returning: model)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getAllLocations(page: Int) async throws -> LocationsResponseModel {
        
        try await withCheckedThrowingContinuation { continuation in
            
            let url = "https://rickandmortyapi.com/api/location?page=\(page)"
            
            AF.request(url,
                       method: .get)
            .responseDecodable(of: LocationsResponseModel.self) { response in
                
                switch response.result {
                case .success(let model):
                    continuation.resume(returning: model)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getAllFavorites() async throws -> FavoritesModel {
        
        async let characters = getFavoriteCharacters()
        async let episodes = getFavoriteEpisodes()
        async let locations = getFavoriteLocations()
        
        let(favoriteCharacters, favoriteEpisodes, favoriteLocations) = try await (characters, episodes, locations)
        
        return FavoritesModel(characters: favoriteCharacters,
                              episodes: favoriteEpisodes,
                              locations: favoriteLocations)
    }
}

private extension NetworkService {
    
    func getFavoriteCharacters() async throws -> [Character] {
        
        try await withCheckedThrowingContinuation { continuation in
            
            let charactersIds = UserDefaultsManager.shared.fetchFavoritesIds(for: StringValue.charactersKey)
            
            guard !charactersIds.isEmpty else {
                return continuation.resume(returning: [])
            }
            
            let urlString = charactersIds.map { String($0) }.joined(separator: ",")
            let charactersURL = "https://rickandmortyapi.com/api/character/\(urlString)"
            
            if charactersIds.count > 1 {
                
                AF.request(charactersURL,
                           method: .get)
                .responseDecodable(of: [Character].self) { response in
                    
                    switch response.result {
                    case .success(let characters):
                        continuation.resume(returning: self.setActualFavoriteStatus(characters: characters))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
                
            } else {
                
                AF.request(charactersURL,
                           method: .get)
                .responseDecodable(of: Character.self) { response in
                    
                    switch response.result {
                    case .success(let character):
                        continuation.resume(returning: self.setActualFavoriteStatus(characters: [character]))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func getFavoriteEpisodes() async throws -> [Episode] {
        
        try await withCheckedThrowingContinuation { continuation in
            
            let episodeIds = UserDefaultsManager.shared.fetchFavoritesIds(for: StringValue.episodesKey)
            
            guard !episodeIds.isEmpty else {
                return continuation.resume(returning: [])
            }
            
            let urlString = episodeIds.map { String($0) }.joined(separator: ",")
            let episodesURL = "https://rickandmortyapi.com/api/episode/\(urlString)"
            
            if episodeIds.count > 1 {
                
                AF.request(episodesURL,
                           method: .get)
                .responseDecodable(of: [Episode].self) { response in
                    
                    switch response.result {
                    case .success(let episodes):
                        continuation.resume(returning: self.setActualFavoriteStatus(episodes: episodes))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
                
            } else {
                
                AF.request(episodesURL,
                           method: .get)
                .responseDecodable(of: Episode.self) { response in
                    
                    switch response.result {
                    case .success(let episode):
                        continuation.resume(returning: self.setActualFavoriteStatus(episodes: [episode]))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func getFavoriteLocations() async throws -> [Location] {
        
        try await withCheckedThrowingContinuation { continuation in
            
            let locationIds = UserDefaultsManager.shared.fetchFavoritesIds(for: StringValue.locationsKey)
            
            guard !locationIds.isEmpty else {
                return continuation.resume(returning: [])
            }
            
            let urlString = locationIds.map { String($0) }.joined(separator: ",")
            let locationsURL = "https://rickandmortyapi.com/api/location/\(urlString)"
            
            if locationIds.count > 1 {
                
                AF.request(locationsURL,
                           method: .get)
                .responseDecodable(of: [Location].self) { response in
                    
                    switch response.result {
                    case .success(let locations):
                        continuation.resume(returning: self.setActualFavoriteStatus(locations: locations))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
                
            } else {
                
                AF.request(locationsURL,
                           method: .get)
                .responseDecodable(of: Location.self) { response in
                    
                    switch response.result {
                    case .success(let location):
                        continuation.resume(returning: self.setActualFavoriteStatus(locations: [location]))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func setActualFavoriteStatus(characters: [Character]) -> [Character] {
        
        var actualCharacters: [Character] = []
        
        characters.forEach { character in
            
            var character = character
            character.isFavorite = true
            actualCharacters.append(character)
        }
        return actualCharacters
    }
    
    func setActualFavoriteStatus(episodes: [Episode]) -> [Episode] {
        
        var actualEpisodes: [Episode] = []
        
        episodes.forEach { episode in
            
            var episode = episode
            episode.isFavorite = true
            actualEpisodes.append(episode)
        }
        return actualEpisodes
    }
    
    func setActualFavoriteStatus(locations: [Location]) -> [Location] {
        
        var actualLocations: [Location] = []
        
        locations.forEach { location in
            
            var location = location
            location.isFavorite = true
            actualLocations.append(location)
        }
        return actualLocations
    }
}
