//
//  CharacterDetailedView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 09.03.2025.
//

import SwiftUI

struct CharacterDetailedView: View {
    
    @Binding var character: Character
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            characterImage
            HStack(alignment: .top) {
                Text(character.name)
                    .font(.system(size: 24,
                                  weight: .bold,
                                  design: .default))
                StatusView(statusType: character.statusType)
                Spacer()
                HeartView(isFavorite: $character.isFavorite, key: StringValue.charactersKey, id: character.id)
                    .padding(.top, -4)
            }
            .padding(.horizontal, 16)
            AttributesView(attributesType: .gender(value: character.gender), size: 28)
                .padding(.horizontal, 16)
            AttributesView(attributesType: .species(value: character.species), size: 28)
                .padding(.horizontal, 16)
            Spacer()
        }
    }
}

private extension CharacterDetailedView {
    
    var characterImage: some View {
        
        AsyncImage(url: URL(string: character.image)) { image in
            image
        } placeholder:{
            Image(.iconNo)
                .resizable()
                .frame(maxWidth: 300, maxHeight: 300, alignment: .center)
        }
        .cornerRadius(10)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.rmGreenBackground)
    }
}
