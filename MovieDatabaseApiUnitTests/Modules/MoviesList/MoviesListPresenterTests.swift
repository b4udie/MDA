//
//  MovieDatabaseApiUnitTests.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import XCTest
@testable import MovieDatabaseApi

class MoviesListPresenterTests: XCTestCase {
    
    var resolver: Resolver!
    var viewController: MoviesListViewControllerMock!
    var moviesListAPIService: MoviesListAPIServiceMock!
    var genresAPIService: GenresAPIServiceMock!
    var imageHelper: ImageHelperMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
                
        viewController = MoviesListViewControllerMock()
        moviesListAPIService = MoviesListAPIServiceMock()
        imageHelper = ImageHelperMock()
        imageHelper.createImageURLStub.setup(nil)
        genresAPIService = GenresAPIServiceMock()
        genresAPIService.loadGenresStub.setup { result in
            let genres = GenresModel(genres: [.init(id: 1, name: "fdfg")])
            return result(.success(genres))
        }
        
        resolver = ResolverMock { container in
            
            container.register(IGenresAPIService.self) { _ in
                self.genresAPIService
            }
            
            container.register(IMoviesListAPIService.self) { _ in
                self.moviesListAPIService
            }
            
            container.register(ISearchAPIService.self) { _ in
                SearchAPIServiceMock()
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
        genresAPIService = nil
        
        try super.tearDownWithError()
    }
    
    func testSuccessfulFlow() throws {
        // Arrange
        let presenter = createPresenter()
        
        let expectation = XCTestExpectation(description: "flow end expectation")
        viewController.setSectionsStub.setup { sections in
            XCTAssertEqual(sections.count, 1)
            XCTAssertEqual(sections.first?.cellsDescriptors.count, 1)
            expectation.fulfill()
        }
        
        moviesListAPIService.loadPopularStub.setup { result in
            let movieModel = MovieModel(id: 123, posterPath: nil, overview: nil, title: "title", voteAverage: 3.0, genreIds: [1])
            let response = SuccessResponse(page: 1, results: [movieModel])
            return result.completion(.success(response))
        }
                    
        // Act
        presenter.viewDidLoad()
        
        // Assert
        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(viewController.setSectionsStub.callsCount, 1)
    }
    
    func testCorruptedDataFlow() throws {
        // Arrange
        let presenter = createPresenter()
        
        let expectation = XCTestExpectation(description: "flow end expectation")
        viewController.setSectionsStub.setup { sections in
            XCTAssertEqual(sections.first?.cellsDescriptors.count, 0)
            expectation.fulfill()
        }
        
        moviesListAPIService.loadPopularStub.setup { result in
            let movieModel = MovieModel(id: nil, posterPath: "test", overview: "test", title: "test", voteAverage: nil, genreIds: nil)
            let response = SuccessResponse(page: 1, results: [movieModel])
            return result.completion(.success(response))
        }
            
        // Act
        presenter.viewDidLoad()
        
        // Assert
        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(viewController.setSectionsStub.callsCount, 1)
    }
    
    private func createPresenter() -> MoviesListPresenter {
        let presenter = MoviesListPresenter(
            interactor: MoviesListInteractor(
                genresAPIService: resolver.resolve(),
                moviesListAPIService: resolver.resolve(),
                searchAPIService: resolver.resolve()
            ),
            moduleOutput: self,
            moviesListDataFactory: .init(imageHelper: resolver.resolve())
        )
        
        presenter.configure(view: viewController)
        
        return presenter
    }
}

extension MoviesListPresenterTests: MoviesListModuleOutput {
    func module(_ input: MoviesListModuleInput, wantsToOpenDetailsWith movie: MovieModel) {
        // unused
    }
}
