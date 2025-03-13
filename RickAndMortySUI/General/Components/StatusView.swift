//
//  StatusView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import SwiftUI

struct StatusView: View {
    
    var statusType: CharacterStatusType
    
    var body: some View {
        
        Text(statusType.rawValue)
            .foregroundStyle(statusType.textColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(statusType.backgroundColor)
            .cornerRadius(10)
    }
}
