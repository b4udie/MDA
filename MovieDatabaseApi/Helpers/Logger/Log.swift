//
//  Log.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 04.04.2022.
//

import Foundation

enum Log {

    private static var logger: LoggerProtocol?

    static func setup(with logger: LoggerProtocol) {
        guard self.logger == nil else {
            Log.error("Log already configured")
            return
        }

        self.logger = logger
    }

    static func error(
        _ error: Error,
        file: String = #file,
        line: UInt = #line,
        function: String = #function
    ) {
        logger?.log(error: error, file: file, line: line, function: function)
    }

    static func error(
        _ message: @autoclosure () -> String,
        file: String = #file,
        line: UInt = #line,
        function: String = #function
    ) {
        logger?.log(
            level: .error,
            message: message(),
            file: file,
            line: line,
            function: function
        )
    }

    static func info(
        _ message: @autoclosure () -> String,
        file: String = #file,
        line: UInt = #line,
        function: String = #function
    ) {
        logger?.log(
            level: .info,
            message: message(),
            file: file,
            line: line,
            function: function
        )
    }
}
