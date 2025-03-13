//
//  AttributesView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 10.03.2025.
//

import SwiftUI

struct AttributesView: View {
    
    let attributesType: AttributesType
    let size: CGFloat
    
    var body: some View {
        
        HStack {
            Text(attributesType.title)
                .font(.system(size: size,
                              weight: .regular,
                              design: .default))
                .foregroundStyle(.rmGray)
            Spacer()
            Text(attributesType.value)
                .font(.system(size: size,
                              weight: .regular,
                              design: .default))
                .foregroundStyle(.rmBlack)
                .lineLimit(1)
        }
    }
}
