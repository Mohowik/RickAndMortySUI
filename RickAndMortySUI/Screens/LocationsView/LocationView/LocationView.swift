//
//  LocationView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 11.03.2025.
//

import SwiftUI

struct LocationView: View {
    
    @Binding var location: Location
    @State private var isPresented: Bool = false
    
    var body: some View {
        locationView
            .padding(EdgeInsets(top: 10,
                                leading: 10,
                                bottom: 10,
                                trailing: 10))
            .frame(maxHeight: 100)
            .background(.white)
            .cornerRadius(16)
            .onTapGesture {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                LocationDetailedView(location: $location)
            }
    }
}

private extension LocationView {
    
    var locationView: some View {
        
        HStack(spacing: 8) {
            locationImage
            VStack(alignment: .leading, spacing: 25) {
                Text(location.name)
                    .lineLimit(2)
                    .font(.system(size: 16,
                                  weight: .medium,
                                  design: .default))
                    .foregroundStyle(.rmBlack)
                    .frame(maxHeight: .infinity, alignment: .top)
                Text(location.type)
                    .lineLimit(1)
                    .font(.system(size: 16,
                                  weight: .regular,
                                  design: .default))
                    .foregroundStyle(.rmGray)
            }
            Spacer()
            HeartView(isFavorite: $location.isFavorite, key: StringValue.locationsKey, id: location.id)
                .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    var locationImage: some View {
        
        Image(location.imageResource)
            .resizable()
            .frame(maxWidth: 80, maxHeight: 80)
            .cornerRadius(10)
    }
}
