//
//  GenresModel.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

struct GenresModel: Decodable {
    struct Genre: Decodable {
        let id: Int?
        let name: String?
    }

    let genres: [Genre]?
}
