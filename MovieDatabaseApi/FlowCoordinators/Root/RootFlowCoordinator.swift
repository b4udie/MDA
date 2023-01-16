//
//  RootFlowCoordinator.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import UIKit

final class RootFlowCoordinator: IFlowCoordinator {
    
    private let resolver: Resolver?
    private let window: UIWindow?
    
    private var moviesListCoodinator: IFlowCoordinator?
    
    init(
        resolver: Resolver?,
        window: UIWindow?
    ) {
        self.resolver = resolver
        self.window = window
    }
    
    func start(animated: Bool) {
        do {
            let moviesListCoordinator = MoviesListCoordinator(
                resolver: try resolver.unwrap(),
                window: try window.unwrap()
            )
            moviesListCoodinator = moviesListCoordinator
            moviesListCoordinator.start(animated: false)
        } catch {
            Log.error(error)
        }
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        // unused
    }
}
