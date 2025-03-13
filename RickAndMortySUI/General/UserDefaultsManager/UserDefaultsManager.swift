//
//  UserDefaultsManager.swift
//  RickAndMortySUI
//
//  Created by Roman Mokh on 11.03.2025.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    func changeFavoriteState(fot id: Int, with key: String) {
        
        var ids = self.fetchFavoritesIds(for: key)
        if let index = ids.firstIndex(where: { $0 == id }) {
            ids.remove(at: index)
        } else {
            ids.append(id)
        }
        UserDefaults.standard.set(ids, forKey: key)
    }
    
    func fetchFavoritesIds(for key: String) -> [Int] {
        return UserDefaults.standard.value(forKey: key) as? [Int] ?? []
    }
}
