//
//  UnspecifiedError.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 04.04.2022.
//

import Foundation

struct UnspecifiedError: LocalizedError {

    let errorDescription: String?

    init(message: String) {
        self.errorDescription = message
    }
}

extension UnspecifiedError: CustomNSError {

    static var errorDomain: String {
        "UnspecifiedError"
    }

    var errorCode: Int {
        1
    }

    var errorUserInfo: [String: Any] {
        if let message = errorDescription {
            return [NSLocalizedDescriptionKey: message]
        }
        return [:]
    }
}
