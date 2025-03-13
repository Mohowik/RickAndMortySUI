//
//  EpisodeDetailedView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import SwiftUI

struct EpisodeDetailedView: View {
    
    @Binding var episode: Episode
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            episodeImage
            HStack(alignment: .top) {
                Text(episode.name)
                    .font(.system(size: 24,
                                  weight: .bold,
                                  design: .default))
                Spacer()
                HeartView(isFavorite: $episode.isFavorite, key: StringValue.episodesKey, id: episode.id)
                    .padding(.top, -4)
            }
            .padding(.horizontal, 16)
            AttributesView(attributesType: .episode(date: episode.airDate.dateEpisode(), number: episode.episode), size: 28)
                .padding(.horizontal, 16)
            Spacer()
        }
    }
}

private extension EpisodeDetailedView {
    
    var episodeImage: some View {
        
        Image(episode.imageResource)
            .cornerRadius(10)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.rmGreenBackground)
    }
}
