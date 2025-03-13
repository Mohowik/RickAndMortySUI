//
//  CustomSegmentedPickerView.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 12.03.2025.
//

import SwiftUI

struct CustomSegmentedPickerView: View {
    
    @Binding var selectedSegment: Int
    
    let segments: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<segments.count, id: \.self) { index in
                
                Text(segments[index])
                    .font(.system(size: 13,
                                  weight: .medium,
                                  design: .default))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, maxHeight: 32)
                    .background(selectedSegment == index ? .rmGreenCyan : .rmGreenSemiLight)
                    .cornerRadius(7)
                    .foregroundColor(selectedSegment == index ? .rmMilkWhite : .rmGreenDark)
                    .onTapGesture {
                        selectedSegment = index
                    }
                if index != segments.count - 1 {
                    Divider()
                        .frame(height: 25)
                }
            }
        }
        .background(.rmGreenSemiLight)
        .cornerRadius(7)
    }
}
