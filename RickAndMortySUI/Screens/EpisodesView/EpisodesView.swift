//
//  EpisodesView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import SwiftUI

struct EpisodesView: View {
    
    @StateObject var viewModel = EpisodesViewModel()
    
    let columns = Array(repeating: GridItem(), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach($viewModel.episodes, id: \.id) { episode in
                        
                        EpisodeView(episode: episode)
                            .onAppear {
                                if episode.id.wrappedValue == viewModel.episodes.last?.id {
                                    self.viewModel.fetchEpisodes()
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
            .navigationBarTitle(Text("Episodes"))
        }
        .tint(.rmGreenCyan)
        .onAppear() {
            viewModel.setActualFavoriteStatus()
        }
    }
}

#Preview {
    EpisodesView()
}
