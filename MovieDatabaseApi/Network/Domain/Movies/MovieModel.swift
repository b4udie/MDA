//
//  MoviesList.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation
import Moya

struct MovieModel: Decodable {
    let id: Int?
    let posterPath: String?
    let overview: String?
    let title: String?
    let voteAverage: Double?
    let genreIds: [Int]?
}
