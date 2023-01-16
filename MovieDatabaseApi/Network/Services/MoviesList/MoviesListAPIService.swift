//
//  MoviesListAPIService.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol IMoviesListAPIService: AnyObject {

    func loadPopular(
        page: Int,
        completion: @escaping (Result<SuccessResponse<[MovieModel]>, Error>) -> Void
    )
    
    func loadCast(
        with movieID: Int,
        completion: @escaping (Result<CastModel, Error>) -> Void
    )
}

final class MoviesListAPIService {
    private let networkEnvironment: INetworkEnvironment
    private let networkService: INetworkService
    
    init(
        networkEnvironment: INetworkEnvironment,
        networkService: INetworkService
    ) {
        self.networkEnvironment = networkEnvironment
        self.networkService = networkService
    }
}

// MARK: IMoviesListAPIService

extension MoviesListAPIService: IMoviesListAPIService {
    
    func loadPopular(
        page: Int,
        completion: @escaping (Result<SuccessResponse<[MovieModel]>, Error>) -> Void
    ) {
        let target = MoviesTarget.getPopular(environment: networkEnvironment, page: page)
        networkService.sendRequest(
            target: target,
            decoder: .convertFromSnakeCaseDecoder,
            completion: completion
        )
    }
    
    func loadCast(
        with movieID: Int,
        completion: @escaping (Result<CastModel, Error>) -> Void
    ) {
        let target = MoviesTarget.getCast(environment: networkEnvironment, movieID: movieID)
        networkService.sendRequest(target: target, completion: completion)
    }
}
