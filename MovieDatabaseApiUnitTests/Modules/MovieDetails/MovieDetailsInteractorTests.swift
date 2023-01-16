//
//  MovieDetailsInteractorTests.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import XCTest
@testable import MovieDatabaseApi

class MovieDetailsInteractorTests: XCTestCase {
    
    var resolver: Resolver!
    var moviesListAPIService: MoviesListAPIServiceMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        moviesListAPIService = MoviesListAPIServiceMock()
        
        resolver = ResolverMock { container in
            
            container.register(IMoviesListAPIService.self) { _ in
                self.moviesListAPIService
            }
        }
    }

    override func tearDownWithError() throws {
        moviesListAPIService = nil
        resolver = nil
        
        try super.tearDownWithError()
    }

    func testSuccessResponseAndResponseHandling() throws {
        // Arrange
        let interactor = createInteractor()
        
        moviesListAPIService.loadCastStub.setup { result in
            XCTAssertEqual(result.movieID, 123)
            let castModel = CastModel(
                cast: [
                    .init(name: "Actor1"),
                    .init(name: "Actor2")
                ]
            )
            return result.completion(.success(castModel))
        }
        
        // Act & Assert
        interactor.loadCast(for: 123) { result in
            switch result {
            case let .success(cast):
                XCTAssertEqual(cast, ["Actor1", "Actor2"])
                
            case .failure:
                XCTFail("Load cast from service has bad response")
            }
        }
    }
    
    func testFailedResponse() throws {
        // Arrange
        let interactor = createInteractor()
        
        moviesListAPIService.loadCastStub.setup { result in
            XCTAssertEqual(result.movieID, 123)

            return result.completion(.failure(TechError.invalidState()))
        }
        
        // Act & Assert
        interactor.loadCast(for: 123) { result in
            switch result {
            case .success:
                XCTFail("Unexpected result")
                
            case let .failure(error):
                XCTAssertNotNil(error as? TechError)
            }
        }
    }

    private func createInteractor() -> MovieDetailsInteractor {
        let interactor = MovieDetailsInteractor(moviesListAPIService: moviesListAPIService)
        return interactor
    }
}
