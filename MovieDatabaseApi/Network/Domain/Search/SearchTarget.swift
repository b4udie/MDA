//
//  SearchTarget.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation
import Moya

enum SearchTarget: TargetType {
    case getMovies(environment: INetworkEnvironment, page: Int, searchText: String)
    
    var baseURL: URL {
        switch self {
        case let .getMovies(environment, _, _):
            return environment.baseURL
        }
    }
    
    var path: String {
        switch self {
        case let .getMovies(environment, _, _):
            return "\(environment.apiVersion)/search/movie"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        switch self {
        case let .getMovies(environment, page, searchText):
            return .requestParameters(
                parameters: [
                    "api_key": environment.apiKey,
                    "page": page,
                    "query": searchText
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String: String]? {
        nil
    }
}
