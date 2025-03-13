//
//  TabBarView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 08.03.2025.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            CharactersView()
                .tabItem {
                    Image(selectedTab == 0 ? .iconCharactersTabSelected : .iconCharactersTab)
                    Text("Characters")
                }
                .tag(0)
            EpisodesView()
                .tabItem {
                    Image(selectedTab == 1 ? .iconEpisodesTabSelected : .iconEpisodesTab)
                    Text("Episodes")
                }
                .tag(1)
            LocationsView()
                .tabItem {
                    Image(selectedTab == 2 ? .iconLocationsTabSelected : .iconLocationsTab)
                    Text("Loactions")
                }
                .tag(2)
            FavoritesView()
                .tabItem {
                    Image(selectedTab == 3 ? .iconFavoritesTabSelected : .iconFavoritesTab)
                    Text("Favorites")
                }
                .tag(3)
        }
        .tint(.rmGreenCyan)
    }
}

#Preview {
    TabBarView()
}
