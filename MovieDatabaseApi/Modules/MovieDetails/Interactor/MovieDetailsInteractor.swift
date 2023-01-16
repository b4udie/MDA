//
//  MovieDetailsInteractor.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

final class MovieDetailsInteractor {

    private let moviesListAPIService: IMoviesListAPIService
    
    private weak var output: MovieDetailsInteractorOutput?
    
    init(
        moviesListAPIService: IMoviesListAPIService
    ) {
        self.moviesListAPIService = moviesListAPIService
    }

    func configure(output: MovieDetailsInteractorOutput?) {
        self.output = output
    }
}

// MARK: MovieDetailsInteractorInput

extension MovieDetailsInteractor: MovieDetailsInteractorInput {
    
    func loadCast(
        for movieID: Int,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        moviesListAPIService.loadCast(with: movieID) { result in
            switch result {
            case let .success(castModel):
                let castNames = castModel.cast?.compactMap { $0.name }
                completion(.success(castNames ?? []))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
