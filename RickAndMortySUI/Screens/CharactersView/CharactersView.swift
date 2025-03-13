//
//  CharactersView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 08.03.2025.
//

import SwiftUI

struct CharactersView: View {
    
    @StateObject var viewModel: CharactersViewModel = CharactersViewModel()
    
    let columns = Array(repeating: GridItem(), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach($viewModel.characters, id: \.id) { character in
                        
                        CharacterView(character: character)
                            .onAppear {
                                if character.id.wrappedValue == viewModel.characters.last?.id {
                                    self.viewModel.fetchCharacters()
                                }
                            }
                    }
                }
                .padding(.bottom, 16)
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .background(.rmGreenBackground)
            .navigationBarTitle(Text("Characters"))
        }
        .tint(.rmGreenCyan)
        .onAppear() {
            viewModel.setActualFavoriteStatus()
        }
    }
}

#Preview {
    CharactersView()
}
