//
//  CharacterStatusType.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import SwiftUI

enum CharacterStatusType: String {
    
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    
    var textColor: Color {
        switch self {
            
        case .alive:
            return .rmGreenCyan
        case .dead:
            return .rmOrangeRed
            
        case .unknown:
            return .rmGray
            
        }
    }
    
    var backgroundColor: Color {
        
        switch self {
            
        case .alive:
            return .rmGreenCyanLight
        case .dead:
            return .rmRedLight
            
        case .unknown:
            return .rmGrayLight
        }
    }
}
