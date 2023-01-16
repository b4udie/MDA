//
//  LoggerProtocol.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 04.04.2022.
//

import Foundation

protocol LoggerProtocol: AnyObject {

    func log(error: Error, file: String, line: UInt, function: String)
    func log(level: LogLevel, message: String, file: String, line: UInt, function: String)
}
