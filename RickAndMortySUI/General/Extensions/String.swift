//
//  String.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 11.03.2025.
//

import Foundation

extension String {
    
    func dateEpisode() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        guard let date = dateFormatter.date(from: self) else { return "" }
        
        dateFormatter.dateStyle = .short
        let resultString = dateFormatter.string(from: date)
        return resultString
    }
}
