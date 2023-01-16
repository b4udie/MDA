//
//  JSONDecoder+KeyDecodingStrategy.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation

extension JSONDecoder {
    static var convertFromSnakeCaseDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
