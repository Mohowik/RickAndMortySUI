//
//  CharacterView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 09.03.2025.
//

import SwiftUI

struct CharacterView: View {
    
    @Binding var character: Character
    @State private var isPresented: Bool = false
    
    var body: some View {
        characterView
            .padding(10)
            .frame(maxWidth: 163)
            .background(.white)
            .cornerRadius(16)
            .onTapGesture {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                CharacterDetailedView(character: $character)
            }
    }
}

private extension CharacterView {
    
    var characterView: some View {
        
        VStack(spacing: 10) {
            ZStack(alignment: .top) {
                characterImage
                statusAndFavoritesStack
            }
            Text(character.name)
                .lineLimit(1)
                .font(.system(size: 14,
                              weight: .medium,
                              design: .default))
                .foregroundStyle(.rmBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            AttributesView(attributesType: .gender(value: character.gender), size: 14)
            AttributesView(attributesType: .species(value: character.species), size: 14)
        }
    }
    
    var characterImage: some View {
        
        AsyncImage(url: URL(string: character.image)) { image in
            image
                .resizable()
        } placeholder:{
            Image(.iconNo)
                .resizable()
        }
        .frame(width: 143, height: 143)
        .cornerRadius(10)
        .padding(.horizontal, 4)
    }
    
    var statusAndFavoritesStack: some View {
        
        HStack {
            StatusView(statusType: character.statusType)
            Spacer()
            HeartView(isFavorite: $character.isFavorite, key: StringValue.charactersKey, id: character.id)
        }
        .padding(.top, -4)
    }
}
