//
//  LocationDetailedView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 11.03.2025.
//

import SwiftUI

struct LocationDetailedView: View {
    
    @Binding var location: Location
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            locationImage
            HStack(alignment: .top) {
                Text(location.name)
                    .font(.system(size: 24,
                                  weight: .bold,
                                  design: .default))
                Spacer()
                HeartView(isFavorite: $location.isFavorite, key: StringValue.locationsKey, id: location.id)
                    .padding(.top, -4)
            }
            .padding(.horizontal, 16)
            AttributesView(attributesType: .location(value: location.type), size: 28)
                .padding(.horizontal, 16)
            Spacer()
        }
    }
}

private extension LocationDetailedView {
    
    var locationImage: some View {
        
        Image(location.imageResource)
            .cornerRadius(10)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(.rmGreenBackground)
    }
}
