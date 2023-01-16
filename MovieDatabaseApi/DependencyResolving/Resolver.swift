//
//  Resolver.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Swinject

protocol Resolver {
    
    func resolveService<Service>(of type: Service.Type) -> Service?
    func resolveService<Service>(of type: Service.Type, name: String) -> Service?
}

extension Resolver {
    
    func resolve<T>() -> T {
        return resolveService(of: T.self)!
    }

    func resolve<T>(name: String) -> T {
        return resolveService(of: T.self, name: name)!
    }
}

extension Swinject.Resolver {
    
    func resolve<T>() -> T {
        return resolve(T.self)!
    }
}
