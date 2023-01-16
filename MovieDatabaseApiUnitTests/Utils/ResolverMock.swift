//
//  ResolverMock.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Swinject
@testable import MovieDatabaseApi

final class ResolverMock: MovieDatabaseApi.Resolver {
    private struct TestAssembly: Assembly {
        let block: (Container) -> Void

        init(_ block: @escaping (Container) -> Void) {
            self.block = block
        }

        func assemble(container: Container) {
            block(container)
        }
    }

    private var assembler: Assembler

    init(_ block: @escaping (Container) -> Void) {
        self.assembler = Assembler()
        assembler.apply(assembly: TestAssembly(block))
    }

    func setup(_ block: @escaping (Container) -> Void) {
        assembler = Assembler()
        assembler.apply(assembly: TestAssembly(block))
    }

    func update(_ block: @escaping (Container) -> Void) {
        assembler.apply(assembly: TestAssembly(block))
    }

    func resolveService<Service>(of type: Service.Type) -> Service? {
        return assembler.resolver.resolve(type)
    }

    func resolveService<Service>(of type: Service.Type, name: String) -> Service? {
        return assembler.resolver.resolve(type, name: name)
    }
}
