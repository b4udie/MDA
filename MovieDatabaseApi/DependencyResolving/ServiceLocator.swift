//
//  ServiceLocator.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Swinject

typealias IServiceLocator = Resolver

final class ServiceLocator: IServiceLocator {
    
    private let serviceAssembler: Assembler
    
    init() {
        serviceAssembler = Assembler([ServiceAssembly()])
    }
    
    func resolveService<Service>(of type: Service.Type) -> Service? {
        serviceAssembler.resolver.resolve(type)
    }
    
    func resolveService<Service>(of type: Service.Type, name: String) -> Service? {
        serviceAssembler.resolver.resolve(type, name: name)
    }
}
