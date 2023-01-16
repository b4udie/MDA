//
//  MoviesListBuilder.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import UIKit

final class MoviesListBuilder {

    // MARK: Private properties

    private let resolver: Resolver
    private weak var moduleOutput: MoviesListModuleOutput!

    // MARK: Lifecycle

    init(resolver: Resolver, moduleOutput: MoviesListModuleOutput) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }

    // MARK: Public methods

    func build() -> UIViewController {
        let interactor = MoviesListInteractor(
            genresAPIService: resolver.resolve(),
            moviesListAPIService: resolver.resolve(),
            searchAPIService: resolver.resolve()
        )

        let presenter = MoviesListPresenter(
            interactor: interactor,
            moduleOutput: moduleOutput,
            moviesListDataFactory: .init(imageHelper: resolver.resolve())
        )

        let viewController = MoviesListViewController.instantiateFrom(
            appStoryboard: .moviesList
        )

        interactor.configure(output: presenter)
        presenter.configure(view: viewController)
        viewController.configure(output: presenter)

        return viewController
    }
}
