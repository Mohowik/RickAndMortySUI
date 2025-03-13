//
//  FavoritesView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 11.03.2025.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var viewModel: FavoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                segmentedPickerView
                    .searchable(text: $viewModel.searchText)
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    
                    switch viewModel.selectedSegment {
                        
                    case 0:
                        favoriteCharactersView
                        
                    case 1:
                        favoriteEpisodesView
                        
                    case 2:
                        favoriteLocationsView
                        
                    default:
                        favoriteCharactersView
                    }
                }
            }
            
            .background(.rmGreenBackground)
            .navigationBarTitle(Text("Favorites"))
        }
        .tint(.rmGreenCyan)
        .onAppear() {
            self.viewModel.fetchAllFavorites()
        }
        .onChange(of: viewModel.searchText) { _ in
            withTransaction(Transaction(animation: nil)) {
                viewModel.filterFavorites()
            }
        }
    }
}

#Preview {
    FavoritesView()
}

private extension FavoritesView {
    
    var segmentedPickerView: some View {
        
        CustomSegmentedPickerView(selectedSegment: $viewModel.selectedSegment,
                                  segments: ["Characters", "Episodes", "Locations"])
        .padding(.horizontal)
    }
    
    var favoriteCharactersView: some View {
        
        ScrollView {
            if viewModel.isEmpty {
                favoritesEmptyView
            } else {
                LazyVGrid(columns: viewModel.columns, spacing: 16) {
                    ForEach($viewModel.favoritesModel.filteredCharacters, id: \.id) { character in
                        
                        CharacterView(character: character)
                            .onChange(of: character.isFavorite.wrappedValue) { newValue in
                                
                                if !viewModel.isLoading {
                                    self.viewModel.fetchAllFavorites()
                                }
                            }
                    }
                }
                .padding(.bottom, 16)
            }
        }
    }
    
    var favoriteEpisodesView: some View {
        
        ScrollView {
            
            if viewModel.isEmpty {
                favoritesEmptyView
            } else {
                LazyVGrid(columns: viewModel.columns, spacing: 16) {
                    ForEach($viewModel.favoritesModel.filteredEpisodes, id: \.id) { episode in
                        
                        EpisodeView(episode: episode)
                            .onChange(of: episode.isFavorite.wrappedValue) { newValue in
                                
                                if !viewModel.isLoading {
                                    self.viewModel.fetchAllFavorites()
                                }
                            }
                    }
                }
                .padding(.bottom, 16)
            }
        }
    }
    
    var favoriteLocationsView: some View {
        
        ScrollView {
            
            if viewModel.isEmpty {
                favoritesEmptyView
            } else {
                LazyVGrid(columns: viewModel.columns, spacing: 16) {
                    ForEach($viewModel.favoritesModel.filteredLocations, id: \.id) { location in
                        
                        LocationView(location: location)
                            .onChange(of: location.isFavorite.wrappedValue) { newValue in
                                
                                if !viewModel.isLoading {
                                    self.viewModel.fetchAllFavorites()
                                }
                            }
                    }
                }
                .padding([.horizontal, .bottom], 16)
            }
        }
    }
    
    var favoritesEmptyView: some View {
        
        VStack {
            Image(.stoneFaceIcon)
                .padding(.top, 45)
            Spacer()
            Text("Чё пучеглазишь, лайкай свой топ\n и он тут появится")
                .multilineTextAlignment(.center)
                .foregroundStyle(.rmGreenDark)
                .padding(.bottom, 25)
            
        }
    }
}
