//
//  GenresAPIService.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol IGenresAPIService {
    
    func loadGenres(completion: @escaping (Result<GenresModel, Error>) -> Void)
}

final class GenresAPIService {
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

// MARK: IGenresAPIService

extension GenresAPIService: IGenresAPIService {
    
    func loadGenres(completion: @escaping (Result<GenresModel, Error>) -> Void) {
        let target = GenresTarget.getGenresList(environment: networkEnvironment)
        networkService.sendRequest(target: target, completion: completion)
    }
}
