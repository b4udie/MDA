//
//  ServiceAssembly.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Swinject

final class ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(INetworkService.self) { _ in
            NetworkService(
                isNetworkLoggingEnabled: true,
                plugins: []
            )
        }.inObjectScope(.container)

        container.register(INetworkEnvironment.self) { _ in
            NetworkEnvironemt()
        }.inObjectScope(.container)
        
        container.register(IMoviesListAPIService.self) { resolver in
            MoviesListAPIService(
                networkEnvironment: resolver.resolve(),
                networkService: resolver.resolve()
            )
        }
        
        container.register(IGenresAPIService.self) { resolver in
            GenresAPIService(
                networkEnvironment: resolver.resolve(),
                networkService: resolver.resolve()
            )
        }

        container.register(IImageHelper.self) { resolver in
            ImageHelper(
                networkEnvironment: resolver.resolve()
            )
        }

        container.register(ISearchAPIService.self) { resolver in
            SearchAPIService(
                networkEnvironment: resolver.resolve(),
                networkService: resolver.resolve()
            )
        }
    }
}
