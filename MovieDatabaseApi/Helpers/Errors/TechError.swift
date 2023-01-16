//
//  TechError.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation

enum TechError: CustomNSError {
    case unexpectedNil(Any.Type, fileID: String = #fileID, function: String = #function, line: UInt = #line)
    case invalidState(associatedValue: Any? = nil, fileID: String = #fileID, function: String = #function, line: UInt = #line)

    static var errorDomain: String {
        return "TechError"
    }

    var errorCode: Int {
        switch self {
        case .unexpectedNil:
            return 1

        case .invalidState:
            return 2
        }
    }

    var errorUserInfo: [String: Any] {
        switch self {
        case let .unexpectedNil(type, fileID, function, line):
            let typeString = String(describing: type)
            let localizedDescription = "Unexpected nil value of type \(typeString) in \(fileID):\(line)"

            return [
                NSLocalizedDescriptionKey: localizedDescription,
                "fileID": fileID,
                "function": function,
                "line": line
            ]

        case let .invalidState(associatedValue, fileID, function, line):
            var userInfo: [String: Any] = [
                "fileID": fileID,
                "function": function,
                "line": line
            ]
            let localizedDescription: String

            if let associatedValue = associatedValue {
                let valueString = String(describing: associatedValue)
                let valueType = type(of: associatedValue)
                let typeString = String(describing: valueType)
                localizedDescription = "Invalid state with associated value \'\(valueString)\' of type \(typeString) in \(fileID):\(line)"

                userInfo["associated-value"] = associatedValue
            } else {
                localizedDescription = "Invalid state in \(fileID):\(line)"
            }

            userInfo[NSLocalizedDescriptionKey] = localizedDescription

            return userInfo
        }
    }
}
