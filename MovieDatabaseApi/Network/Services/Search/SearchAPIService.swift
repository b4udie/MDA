//
//  SearchAPIService.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol ISearchAPIService: AnyObject {
    
    func loadMovies(
        by searchText: String,
        page: Int,
        completion: @escaping (Result<SuccessResponse<[MovieModel]>, Error>) -> Void
    )
}

final class SearchAPIService {
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

// MARK: ISearchAPIService

extension SearchAPIService: ISearchAPIService {
    
    func loadMovies(
        by searchText: String,
        page: Int,
        completion: @escaping (Result<SuccessResponse<[MovieModel]>, Error>) -> Void
    ) {
        let target = SearchTarget.getMovies(
            environment: networkEnvironment,
            page: page,
            searchText: searchText
        )
        
        networkService.sendRequest(
            target: target,
            decoder: .convertFromSnakeCaseDecoder,
            completion: completion
        )
    }
}
