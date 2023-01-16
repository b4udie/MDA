//
//  DefaultInitializable.swift
//  MovieDatabaseApiUnitTests
//
//  Created by Val Bratkevich on 31.03.2022.
//

import Foundation

protocol DefaultInitializable {
    init()
}

extension Array: DefaultInitializable {}
extension Dictionary: DefaultInitializable {}
extension Set: DefaultInitializable {}
extension Int: DefaultInitializable {}
extension UInt: DefaultInitializable {}
extension Float: DefaultInitializable {}
extension Double: DefaultInitializable {}
extension String: DefaultInitializable {}
extension Bool: DefaultInitializable {}
extension Data: DefaultInitializable {}
