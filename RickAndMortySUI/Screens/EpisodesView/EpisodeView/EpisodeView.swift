//
//  EpisodeView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import SwiftUI

struct EpisodeView: View {
    
    @Binding var episode: Episode
    @State private var isPresented: Bool = false
    
    var body: some View {
        episodeView
            .padding(10)
            .frame(maxWidth: 163)
            .background(.white)
            .cornerRadius(16)
            .onTapGesture {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                EpisodeDetailedView(episode: $episode)
            }
    }
}

private extension EpisodeView {
    
    var episodeView: some View {
        
        VStack(spacing: 10) {
            ZStack(alignment: .top) {
                episodeImage
                favoritesStack
            }
            .padding(.all, 0)
            Text(episode.name)
                .lineLimit(1)
                .font(.system(size: 14,
                              weight: .medium,
                              design: .default))
                .foregroundStyle(.rmBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            AttributesView(attributesType: .episode(date: episode.airDate.dateEpisode(), number: episode.episode), size: 14)
        }
    }
    
    var episodeImage: some View {
        
        Image(episode.imageResource)
            .resizable()
            .frame(maxWidth: 163)
            .cornerRadius(10)
    }
    
    var favoritesStack: some View {
        
        HStack {
            Spacer()
            HeartView(isFavorite: $episode.isFavorite, key: StringValue.episodesKey, id: episode.id)
        }
        .padding(.top, -4)
    }
}
