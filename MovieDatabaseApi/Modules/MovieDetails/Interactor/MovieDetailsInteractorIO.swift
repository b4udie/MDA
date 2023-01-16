//
//  MovieDetailsInteractorIO.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol MovieDetailsInteractorInput: AnyObject {
    
    func loadCast(
        for movieID: Int,
        completion: @escaping (Result<[String], Error>) -> Void
    )
}

protocol MovieDetailsInteractorOutput: AnyObject { }
