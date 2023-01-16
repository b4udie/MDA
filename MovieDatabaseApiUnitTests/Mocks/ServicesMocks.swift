//
//  ServicesMocks.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Foundation
@testable import MovieDatabaseApi

class GenresAPIServiceMock: IGenresAPIService {
    
    let loadGenresStub = MethodStub<(Result<GenresModel, Error>) -> Void, ()>()
    func loadGenres(completion: @escaping (Result<GenresModel, Error>) -> Void) {
        loadGenresStub.call(with: completion)
    }
}

class MoviesListAPIServiceMock: IMoviesListAPIService {
    
    let loadPopularStub = MethodStub<(page: Int, completion: (Result<SuccessResponse<[MovieModel]>, Error>) -> Void), Void>()
    func loadPopular(page: Int, completion: @escaping (Result<SuccessResponse<[MovieModel]>, Error>) -> Void) {
        loadPopularStub.call(with: (page, completion))
    }
    
    let loadCastStub = MethodStub<(movieID: Int, completion: (Result<CastModel, Error>) -> Void), Void>()
    func loadCast(with movieID: Int, completion: @escaping (Result<CastModel, Error>) -> Void) {
        loadCastStub.call(with: (movieID, completion))
    }
}

class SearchAPIServiceMock: ISearchAPIService {
    
    let loadMoviesStub = MethodStub<(searchText: String, page: Int, completion: (Result<SuccessResponse<[MovieModel]>, Error>) -> Void), Void>()
    func loadMovies(by searchText: String, page: Int, completion: @escaping (Result<SuccessResponse<[MovieModel]>, Error>) -> Void) {
        loadMoviesStub.call(with: (searchText, page, completion))
    }
}

class ImageHelperMock: IImageHelper {
    
    let createImageURLStub = MethodStub<(imagePath: String?, quality: ImageHelper.Size), URL?>()
    func createImageURL(with imagePath: String?, quality: ImageHelper.Size) -> URL? {
        createImageURLStub.call(with: (imagePath, quality))
    }
}
