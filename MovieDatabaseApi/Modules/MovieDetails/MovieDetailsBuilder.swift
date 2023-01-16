//
//  MovieDetailsBuilder.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit

final class MovieDetailsBuilder {

    // MARK: Private properties

    private let resolver: Resolver
    private weak var moduleOutput: MovieDetailsModuleOutput!
    private let movie: MovieModel

    // MARK: Lifecycle

    init(resolver: Resolver, movie: MovieModel, moduleOutput: MovieDetailsModuleOutput) {
        self.resolver = resolver
        self.movie = movie
        self.moduleOutput = moduleOutput
    }

    // MARK: Public ethods

    func build() -> UIViewController {
        let interactor = MovieDetailsInteractor(
            moviesListAPIService: resolver.resolve()
        )

        let presenter = MovieDetailsPresenter(
            interactor: interactor,
            movie: movie,
            moduleOutput: moduleOutput,
            movieDetailsFactory: .init(imageHelper: resolver.resolve())
        )

        let viewController = MovieDetailsViewController.instantiateFrom(
            appStoryboard: .movieDetails
        )

        interactor.configure(output: presenter)
        presenter.configure(view: viewController)
        viewController.configure(output: presenter)

        return viewController
    }
}
