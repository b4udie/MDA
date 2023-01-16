//
//  MoviesListCoordinator.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import UIKit

final class MoviesListCoordinator: IFlowCoordinator {
    
    private let resolver: Resolver
    private let window: UIWindow
    
    private var moviesListNavigationController: UINavigationController?
    
    init(
        resolver: Resolver,
        window: UIWindow
    ) {
        self.resolver = resolver
        self.window = window
    }
    
    func start(animated: Bool) {
        let controller = MoviesListBuilder(resolver: resolver, moduleOutput: self).build()
        let navigationController = NavigationController(rootViewController: controller)
        moviesListNavigationController = navigationController
        window.rootViewController = navigationController
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        // unused
    }
}

// MARK: MoviesListModuleOutput

extension MoviesListCoordinator: MoviesListModuleOutput {
    func module(_ input: MoviesListModuleInput, wantsToOpenDetailsWith movie: MovieModel) {
        let viewController = MovieDetailsBuilder(
            resolver: resolver,
            movie: movie,
            moduleOutput: self
        ).build()
        
        do {
            try moviesListNavigationController.unwrap().pushViewController(viewController, animated: true)
        } catch {
            Log.error(error)
        }
    }
}

// MARK: MovieDetailsModuleOutput

extension MoviesListCoordinator: MovieDetailsModuleOutput { }
