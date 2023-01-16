//
//  MovieDetailsPresenterTests.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import XCTest
@testable import MovieDatabaseApi

class MovieDetailsPresenterTests: XCTestCase {
    
    var resolver: Resolver!
    var viewController: MovieDetailsViewControllerMock!
    var moviesListAPIService: MoviesListAPIServiceMock!
    var imageHelper: ImageHelperMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    
        viewController = MovieDetailsViewControllerMock()
        moviesListAPIService = MoviesListAPIServiceMock()
        imageHelper = ImageHelperMock()
        imageHelper.createImageURLStub.setup(nil)
        
        resolver = ResolverMock { container in
        
            container.register(IMoviesListAPIService.self) { _ in
                self.moviesListAPIService
            }
            
            container.register(IImageHelper.self) { _ in
                self.imageHelper
            }
        }
    }
    
    override func tearDownWithError() throws {
        viewController = nil
        moviesListAPIService = nil
        imageHelper = nil
        
        try super.tearDownWithError()
    }
    
    func testSuccessfulFlow() throws {
        // Arrange
        let presenter = createPresenter(
            with: .init(
                id: 1, posterPath: "path", overview: "overview",
                title: "title", voteAverage: 10.0, genreIds: [1]
            )
        )
        
        moviesListAPIService.loadCastStub.setup { result in
            let castModel = CastModel(cast: [.init(name: "Actor Name")])
            return result.completion(.success(castModel))
        }
        
        viewController.configureStub.setup { movie in
            XCTAssertEqual(movie.id, 1)
            XCTAssertEqual(movie.posterPath, "path")
        }
        
        let expectation = XCTestExpectation(description: "flow end expectation")
        viewController.setSectionsStub.setup { sections in
            XCTAssertEqual(sections.count, 3)
            XCTAssertEqual(sections[0].cellsDescriptors.count, 1)
            XCTAssertEqual(sections[1].cellsDescriptors.count, 1)
            XCTAssertEqual(sections[2].cellsDescriptors.count, 1)
            expectation.fulfill()
        }
        
        // Act
        presenter.viewDidLoad()
        
        // Assert
        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(viewController.setSectionsStub.callsCount, 1)
    }
    
    func testCorruptedDataFlow() throws {
        // Arrange
        let presenter = createPresenter(
            with: .init(id: nil, posterPath: nil, overview: nil, title: nil, voteAverage: nil, genreIds: nil)
        )
                
        viewController.configureStub.setup { movie in
            XCTAssertEqual(movie.id, nil)
            XCTAssertEqual(movie.posterPath, nil)
        }
                
        // Act
        presenter.viewDidLoad()
        
        // Assert
        XCTAssertEqual(viewController.setSectionsStub.isCalled, false)
        XCTAssertEqual(viewController.configureStub.isCalled, true)
        XCTAssertEqual(moviesListAPIService.loadCastStub.isCalled, false)
    }
    
    private func createPresenter(with movie: MovieModel) -> MovieDetailsPresenter {
        let presenter = MovieDetailsPresenter(
            interactor: MovieDetailsInteractor(
                moviesListAPIService: resolver.resolve()
            ),
            movie: movie,
            moduleOutput: self,
            movieDetailsFactory: MovieDetailsFactory(imageHelper: resolver.resolve())
        )
        
        presenter.configure(view: viewController)
        
        return presenter
    }
}

extension MovieDetailsPresenterTests: MovieDetailsModuleOutput { }
