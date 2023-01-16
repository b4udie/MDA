//
//  Optional+Unwrap.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation

extension Optional {
    func unwrap(
        fileID: String = #fileID,
        function: String = #function,
        line: UInt = #line
    ) throws -> Wrapped {
        switch self {
        case let .some(wrapped):
            return wrapped

        case .none:
            throw TechError.unexpectedNil(
                Wrapped.self,
                fileID: fileID,
                function: function,
                line: line
            )
        }
    }
}
