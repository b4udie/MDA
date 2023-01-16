//
//  MoviesTarget.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation
import Moya

enum MoviesTarget: TargetType {
    case getPopular(environment: INetworkEnvironment, page: Int)
    case getCast(environment: INetworkEnvironment, movieID: Int)
    
    var baseURL: URL {
        switch self {
        case let .getPopular(environment, _),
            let .getCast(environment, _):
            
            return environment.baseURL
        }
    }
    
    var path: String {
        switch self {
        case let .getPopular(environment, _):
            return "\(environment.apiVersion)/movie/popular"
            
        case let .getCast(environment, movieID):
            return "\(environment.apiVersion)/movie/\(movieID)/credits"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        switch self {
        case let .getPopular(environment, page):
            return .requestParameters(
                parameters: [
                    "api_key": environment.apiKey,
                    "page": page
                ],
                encoding: URLEncoding.queryString
            )
            
        case let .getCast(environment, _):
            return .requestParameters(
                parameters: [
                    "api_key": environment.apiKey
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String: String]? {
        nil
    }
}
