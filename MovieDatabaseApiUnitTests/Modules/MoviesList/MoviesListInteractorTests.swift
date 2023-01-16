//
//  MoviesListInteractorTests.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 01.04.2022.
//

import XCTest
@testable import MovieDatabaseApi

class MoviesListInteractorTests: XCTestCase {
    
    var resolver: Resolver!
    var moviesListAPIService: MoviesListAPIServiceMock!
    var genresAPIService: GenresAPIServiceMock!
    var searchAPIService: SearchAPIServiceMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        moviesListAPIService = MoviesListAPIServiceMock()
        genresAPIService = GenresAPIServiceMock()
        searchAPIService = SearchAPIServiceMock()
        
        resolver = ResolverMock { container in
            
            container.register(IMoviesListAPIService.self) { _ in
                self.moviesListAPIService
            }
            
            container.register(IGenresAPIService.self) { _ in
                self.genresAPIService
            }
            
            container.register(ISearchAPIService.self) { _ in
                self.searchAPIService
            }
        }
    }

    override func tearDownWithError() throws {
        moviesListAPIService = nil
        resolver = nil
        
        try super.tearDownWithError()
    }

    func testSuccessResponseAndResponseHandlingLoadGenres() throws {
        // Arrange
        let interactor = createInteractor()
        
        genresAPIService.loadGenresStub.setup { completion in
            let genres = GenresModel(genres: [.init(id: 1, name: "Name")])
            return completion(.success(genres))
        }
        
        // Act & Assert
        interactor.loadGenres { result in
            switch result {
            case let .success(genres):
                XCTAssertEqual(genres?[0].id, 1)
                XCTAssertEqual(genres?[0].name, "Name")
            
            case .failure:
                XCTFail("Unexpected state")
            }
        }
    }
    
    func testFailedResponseLoadGenres() throws {
        // Arrange
        let interactor = createInteractor()
        
        genresAPIService.loadGenresStub.setup { completion in
            return completion(.failure(TechError.invalidState()))
        }

        // Act & Assert
        interactor.loadGenres { result in
            switch result {
            case .success:
                XCTFail("Unexpected state")
            
            case let .failure(error):
                XCTAssertNotNil(error as? TechError)
            }
        }
    }

    func testSuccessResponseAndResponseHandlingLoadPopular() throws {
        // Arrange
        let interactor = createInteractor()
        
        moviesListAPIService.loadPopularStub.setup { result in
            let movieModel = MovieModel(
                id: 1, posterPath: "path", overview: "overview",
                title: "title", voteAverage: 3.0, genreIds: [1]
            )
            let response = SuccessResponse(page: 1, results: [movieModel])
            return result.completion(.success(response))
        }
        
        // Act & Assert
        interactor.loadPopularList { result in
            switch result {
            case let .success(movieModel):
                XCTAssertEqual(movieModel?[0].id, 1)
                XCTAssertEqual(movieModel?[0].title, "title")
                XCTAssertEqual(movieModel?[0].voteAverage, 3.0)
                XCTAssertNil(movieModel?[safe: 1])
            
            case .failure:
                XCTFail("Unexpected state")
            }
        }
    }
    
    func testFailedResponseLoadPopular() throws {
        // Arrange
        let interactor = createInteractor()
        
        moviesListAPIService.loadPopularStub.setup { result in
            return result.completion(.failure(TechError.invalidState()))
        }

        // Act & Assert
        interactor.loadPopularList { result in
            switch result {
            case .success:
                XCTFail("Unexpected state")
            
            case let .failure(error):
                XCTAssertNotNil(error as? TechError)
            }
        }
    }

    func testSuccessResponseAndResponseHandlingLoadMovies() throws {
        // Arrange
        let interactor = createInteractor()
        
        searchAPIService.loadMoviesStub.setup { result in
            XCTAssertEqual(result.searchText, "testSearchText")
            
            let movieModel = MovieModel(
                id: 1, posterPath: "path", overview: "overview",
                title: "title", voteAverage: 3.0, genreIds: [1]
            )
            let response = SuccessResponse(page: 1, results: [movieModel])
            return result.completion(.success(response))
        }
        
        // Act & Assert
        interactor.loadMovies(by: "testSearchText") { result in
            switch result {
            case let .success(movieModel):
                XCTAssertEqual(movieModel?[0].id, 1)
                XCTAssertEqual(movieModel?[0].title, "title")
                XCTAssertEqual(movieModel?[0].voteAverage, 3.0)
                XCTAssertNil(movieModel?[safe: 1])
            
            case .failure:
                XCTFail("Unexpected state")
            }
        }
    }
    
    func testFailedResponseLoadMovies() throws {
        // Arrange
        let interactor = createInteractor()
        
        searchAPIService.loadMoviesStub.setup { result in
            XCTAssertEqual(result.searchText, "testSearchText")
            
            return result.completion(.failure(TechError.invalidState()))
        }

        // Act & Assert
        interactor.loadMovies(by: "testSearchText") { result in
            switch result {
            case .success:
                XCTFail("Unexpected state")
            
            case let .failure(error):
                XCTAssertNotNil(error as? TechError)
            }
        }
    }

    private func createInteractor() -> MoviesListInteractor {
        let interactor = MoviesListInteractor(
            genresAPIService: genresAPIService,
            moviesListAPIService: moviesListAPIService,
            searchAPIService: searchAPIService
        )
        
        return interactor
    }
}
