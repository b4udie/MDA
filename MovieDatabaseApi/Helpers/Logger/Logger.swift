//
//  Logger.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 04.04.2022.
//

import Foundation

final class Logger: LoggerProtocol {
    func log(error: Error, file: String, line: UInt, function: String) {
        let levelString = "ERROR"
        logMessage(
            message: error.localizedDescription,
            levelString: levelString,
            file: file,
            line: line,
            function: function
        )
    }
    
    func log(level: LogLevel, message: String, file: String, line: UInt, function: String) {
        switch level {
        case .info:
            logAsInfo(
                message: message,
                file: file,
                line: line,
                function: function
            )

        case .error:
            log(
                error: UnspecifiedError(message: message),
                file: file,
                line: line,
                function: function
            )
        }
    }
        
    private func logAsInfo(message: String, file: String, line: UInt, function: String) {
        let levelString = "INFO"
        logMessage(
            message: message,
            levelString: levelString,
            file: file,
            line: line,
            function: function
        )
    }
    
    private func logMessage(message: String, levelString: String, file: String, line: UInt, function: String) {
        let fileName = file.split(separator: "/").last?.split(separator: ".").first ?? "<no filename>"
        let logString = "(\(levelString)) [\(fileName) \(function) (\(line))] Description: \(message)"
        
        print(logString)
        
        // MARK: Here we should send our log to remote (ex. Firebase analytics)
    }
}
