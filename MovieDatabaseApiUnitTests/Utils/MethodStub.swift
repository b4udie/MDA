//
//  MethodStub.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Foundation
import XCTest

public protocol AnyMethodStub {
    var callsCount: Int { get }

    func call<T>(with: Any) -> T

    func tryCall<T>(with: Any) throws -> T
}

public extension AnyMethodStub {
    var isCalled: Bool { callsCount > 0 }
}

public final class MethodStub<Arguments, Return> {
    public typealias Block = (Arguments) throws -> Return

    public struct Call {
        public let args: Arguments
        public let result: Result<Return, Error>

        public var returnValue: Return {
            switch result {
            case let .success(value):
                return value

            case let .failure(error):
                return defaultValueAndFail("Unexpected error: \(error)")
            }
        }
    }

    private var block: Block?
    private let lock = NSRecursiveLock()
    private var _calls: [Call] = []

    public var calls: [Call] {
        sync { _calls }
    }

    public init(_ block: Block? = nil) {
        self.block = block
    }

    public func call(
        with args: Arguments,
        function: StaticString = #function,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Return {
        sync {
            guard let block = block else {
                return defaultValueAndFail("Unexpected call \(function)", file: file, line: line)
            }
            do {
                let result = try block(args)
                _calls.append(Call(args: args, result: .success(result)))
                return result
            } catch {
                return defaultValueAndFail("Unexpected error: \(error)")
            }
        }
    }

    public func tryCall(
        with args: Arguments,
        function: StaticString = #function,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> Return {
        try sync {
            guard let block = block else {
                XCTFail("Unexpected call \(function)", file: file, line: line)
                return try defaultValue()
            }
            do {
                let result = try block(args)
                _calls.append(Call(args: args, result: .success(result)))
                return result
            } catch {
                _calls.append(Call(args: args, result: .failure(error)))
                throw error
            }
        }
    }

    public func setup(_ block: @escaping (Arguments) throws -> Return) {
        sync {
            self.block = block
            _calls.removeAll()
        }
    }

    public func setup(_ block: @autoclosure @escaping () throws -> Return) {
        sync {
            self.block = { _ in
                try block()
            }
            _calls.removeAll()
        }
    }

    public func reset() {
        sync {
            block = nil
            _calls.removeAll()
        }
    }

    private func sync<T>(_ block: () throws -> T) rethrows -> T {
        XCTAssertTrue(lock.lock(before: Date().addingTimeInterval(5)), "Failed to acquire lock after 5 seconds. This is a potentially deadlock ☠️")
        defer { lock.unlock() }
        return try block()
    }
    
}

extension MethodStub: AnyMethodStub {
    public var callsCount: Int { calls.count }

    public func call<T>(with any: Any) -> T {
        guard let arguments = any as? Arguments else {
            return defaultValueAndFail("Invalid arguments type '\(type(of: any))'. Expected '\(Arguments.self)'")
        }
        let result = call(with: arguments)
        guard let expectedResult = result as? T else {
            return defaultValueAndFail("Invalid result type '\(Return.self)'. Expected '\(T.self)'")
        }
        return expectedResult
    }

    public func tryCall<T>(with any: Any) throws -> T {
        guard let arguments = any as? Arguments else {
            return defaultValueAndFail("Invalid arguments type '\(type(of: any))'. Expected '\(Arguments.self)'")
        }
        let result = try tryCall(with: arguments)
        guard let expectedResult = result as? T else {
            return defaultValueAndFail("Invalid result type '\(Return.self)'. Expected '\(T.self)'")
        }
        return expectedResult
    }
}

public extension MethodStub where Arguments == Void {
    func call(function: StaticString = #function, file: StaticString = #file, line: UInt = #line) -> Return {
        return call(with: (), function: function, file: file, line: line)
    }
}

public extension MethodStub where Return == Void {
    func setup() {
        setup(())
    }
}

extension MethodStub: ExpressibleByBooleanLiteral where Return == Bool {
    public typealias BooleanLiteralType = Bool

    public convenience init(booleanLiteral value: BooleanLiteralType) {
        self.init()
        setup(value)
    }
}

enum TestError: Error {
    case noDefaultValue(for: Any.Type)
}

func defaultValue<T>(for type: T.Type = T.self) throws -> T {
    let any: Any

    switch type {
    case let type as ExpressibleByNilLiteral.Type:
        // nil for all optional types
        any = type.init(nilLiteral: ())

    case let type as DefaultInitializable.Type:
        any = type.init()

    case is URL.Type:
        any = URL(fileURLWithPath: "")

    default:
        // Void and other types
        any = ()
    }

    guard let result = any as? T else {
        throw TestError.noDefaultValue(for: type)
    }
    return result
}

func defaultValueAndFail<T>(
    for type: T.Type = T.self,
    _ message: String = "",
    file: StaticString = #file,
    line: UInt = #line
) -> T {
    do {
        let result = try defaultValue(for: type)
        XCTFail(message, file: file, line: line)
        return result
    } catch {
        // skip error
    }
    fatalError(message, file: file, line: line)
}
