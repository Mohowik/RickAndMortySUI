//
//  AttributesType.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import Foundation

enum AttributesType {
    
    case gender(value: String)
    case species(value: String)
    case episode(date: String,
                 number: String)
    case location(value: String)
    
    var value: String {
        switch self {
        case .gender(let value):
            return value
        case .species(let value):
            return value
        case .episode( _,
                       let number):
            return number
        case .location(let value):
            return value
        }
    }
    
    var title: String {
        switch self {
        case .gender:
            return "Gender:"
        case .species:
            return "Species:"
        case .episode(let date,
                      _):
            return date
        case .location:
            return "Type:"
        }
    }
}
