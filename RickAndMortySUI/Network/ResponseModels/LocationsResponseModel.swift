//
//  LocationsResponseModel.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import Foundation

struct LocationsResponseModel: Decodable & Sendable {
    
    enum CodingKeys: String, CodingKey {
        case info
        case locations = "results"
    }
    
    let info: LocationsInfo
    let locations: [Location]
}

struct LocationsInfo: Decodable {
    
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Location: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case type
        case dimension
        case residents
        case url
        case created
    }
    
    var id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    var isFavorite: Bool = false
    
    var imageResource: ImageResource {
        self.type == "Planet" ?  .iconPlanet : .iconUniverse
    }
}
