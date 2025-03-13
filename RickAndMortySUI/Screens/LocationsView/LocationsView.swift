//
//  LocationsView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 11.03.2025.
//

import SwiftUI

struct LocationsView: View {
    
    @StateObject var viewModel = LocationsViewModel()
    
    let columns = Array(repeating: GridItem(), count: 1)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach($viewModel.locations, id: \.id) { location in
                        
                        LocationView(location: location)
                            .onAppear {
                                if location.id.wrappedValue == viewModel.locations.last?.id {
                                    self.viewModel.fetchLocations()
                                }
                            }
                    }
                }
                .padding([.horizontal, .bottom], 16)
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
    LocationsView()
}
