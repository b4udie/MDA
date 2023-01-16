//
//  MoviesListInteractorIO.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol MoviesListInteractorInput: AnyObject {
    
    func loadGenres(completion: @escaping (Result<[GenresModel.Genre]?, Error>) -> Void)
    func loadPopularList(completion: @escaping (Result<[MovieModel]?, Error>) -> Void)
    func loadMovies(
        by searchText: String,
        completion: @escaping (Result<[MovieModel]?, Error>) -> Void
    )
}

protocol MoviesListInteractorOutput: AnyObject { }
