//
//  CastModel.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Foundation

struct CastModel: Decodable {
    struct Cast: Decodable {
        let name: String?
    }
    
    let cast: [Cast]?
}
