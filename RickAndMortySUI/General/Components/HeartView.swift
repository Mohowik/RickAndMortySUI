//
//  HeartView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import SwiftUI

struct HeartView: View {
    
    @Binding var isFavorite: Bool
    let key: String
    let id: Int
    
    var body: some View {
        Image(isFavorite ? .iconHeartFill : .iconHeartEmpty)
            .frame(width: 24, height: 24)
            .padding(.all, 4)
            .background(.white)
            .cornerRadius(16)
            .shadow(radius: 5)
            .onTapGesture {
                isFavorite.toggle()
                UserDefaultsManager.shared.changeFavoriteState(fot: id,
                                                               with: key)
            }
    }
}
