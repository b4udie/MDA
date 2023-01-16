//
//  Collection+Safe.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
