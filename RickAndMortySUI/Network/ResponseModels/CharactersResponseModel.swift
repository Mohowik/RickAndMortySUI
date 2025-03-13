//
//  CharactersResponseModel.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 08.03.2025.
//

import Foundation
import SwiftUI

struct CharactersResponseModel: Decodable & Sendable {
    
    enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
    let info: CharactersInfo
    let characters: [Character]
}

struct CharactersInfo: Decodable {
    
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }
    
    var id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin : CharacterOrigin
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var statusType: CharacterStatusType {
        
        switch status {
            
        case "Alive":
            return .alive
        case "Dead":
            return .dead
        default:
            return .unknown
        }
    }
    
    var isFavorite: Bool = false
}

struct CharacterOrigin: Decodable {
    
    let name: String
    let url: String
}

struct CharacterLocation: Decodable {
    
    let name: String
    let url: String
}
