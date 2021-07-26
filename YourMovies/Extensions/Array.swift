//
//  Array.swift
//  Array
//
//  Created by Nikita Nikitin on 26.07.2021.
//

import Foundation

extension Array where Element == Film {
    
    func updatePath(withStoreImageUrl url: String) -> Self {
        self.map { item in
            var locItem = item
            locItem.updatePath(withStoreImageUrl: url)
            return locItem
        }
    }
}
