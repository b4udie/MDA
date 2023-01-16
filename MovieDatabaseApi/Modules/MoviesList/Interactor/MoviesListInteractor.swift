//
//  MoviesListInteractor.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation

final class MoviesListInteractor {
    private enum Constants {
        static let minimumRequestPage: Int = 1
        static let maximumRequestPage: Int = 5
    }
    
    private let genresAPIService: IGenresAPIService
    private let moviesListAPIService: IMoviesListAPIService
    private let searchAPIService: ISearchAPIService
    
    private weak var output: MoviesListInteractorOutput?
    
    private var popularListRequestPage: Int = Constants.minimumRequestPage
    private var searchMovieRequestPage: Int = Constants.minimumRequestPage
    private var searchText: String = ""
    
    init(
        genresAPIService: IGenresAPIService,
        moviesListAPIService: IMoviesListAPIService,
        searchAPIService: ISearchAPIService
    ) {
        self.genresAPIService = genresAPIService
        self.moviesListAPIService = moviesListAPIService
        self.searchAPIService = searchAPIService
    }
        
    func configure(output: MoviesListInteractorOutput?) {
        self.output = output
    }
}

// MARK: Private

private extension MoviesListInteractor {
    
    func handleMoviesList(
        result: (Result<SuccessResponse<[MovieModel]>, Error>),
        requestPage: inout Int,
        completion: @escaping (Result<[MovieModel]?, Error>) -> Void
    ) {
        switch result {
        case let .success(moviesListModel):
            if let page = moviesListModel.page {
                requestPage = page + 1
            } else {
                return completion(.failure(TechError.invalidState()))
            }
                        
            completion(.success(moviesListModel.results))
            
        case let .failure(error):
            completion(.failure(error))
        }
    }
}

// MARK: MoviesListInteractorInput

extension MoviesListInteractor: MoviesListInteractorInput {
    
    func loadGenres(
        completion: @escaping (Result<[GenresModel.Genre]?, Error>) -> Void
    ) {
        genresAPIService.loadGenres { result in
            switch result {
            case let .success(genresModel):
                completion(.success(genresModel.genres))
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func loadPopularList(
        completion: @escaping (Result<[MovieModel]?, Error>) -> Void
    ) {
        guard popularListRequestPage <= Constants.maximumRequestPage else { return }
        
        moviesListAPIService.loadPopular(page: popularListRequestPage) { [weak self] result in
            guard let self = self else { return }
            
            self.handleMoviesList(result: result, requestPage: &self.popularListRequestPage, completion: completion)
        }
    }
    
    func loadMovies(
        by searchText: String,
        completion: @escaping (Result<[MovieModel]?, Error>) -> Void
    ) {
        if self.searchText != searchText {
            searchMovieRequestPage = Constants.minimumRequestPage
        }

        self.searchText = searchText
        
        guard searchMovieRequestPage <= Constants.maximumRequestPage else { return }
        
        searchAPIService.loadMovies(
            by: searchText,
            page: searchMovieRequestPage
        ) { [weak self] result in
            guard let self = self else { return }
            
            self.handleMoviesList(result: result, requestPage: &self.searchMovieRequestPage, completion: completion)
        }
    }
}
