//
//  EpisodesResponseModel.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import SwiftUI

struct EpisodesResponseModel: Decodable & Sendable {
    
    enum CodingKeys: String, CodingKey {
        case info
        case episodes = "results"
    }
    
    let info: CharactersInfo
    let episodes: [Episode]
}

struct EpisodesInfo: Decodable {
    
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Episode: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
    
    var id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
    var isFavorite: Bool = false
    
    var imageResource: ImageResource {
        
        let numberOfSeason = episode[episode.index(episode.startIndex, offsetBy: 2)]
        switch numberOfSeason {
        case "1":
            return .iconSeason1
        case "2":
            return .iconSeason2
        case "3":
            return .iconSeason3
        case "4":
            return .iconSeason4
        case "5":
            return .iconSeason5
        default:
            return .iconSeason1
        }
    }
}
