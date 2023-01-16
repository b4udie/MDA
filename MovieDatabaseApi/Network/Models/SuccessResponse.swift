//
//  SuccessResponse.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation

struct SuccessResponse<T: Decodable>: Decodable {
    let page: Int?
    let results: T?
}
