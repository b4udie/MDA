//
//  GenresTarget.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation
import Moya

enum GenresTarget: TargetType {
    case getGenresList(environment: INetworkEnvironment)
    
    var baseURL: URL {
        switch self {
        case let .getGenresList(environment):
            return environment.baseURL
        }
    }
    
    var path: String {
        switch self {
        case let .getGenresList(environment):
            return "\(environment.apiVersion)/genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        switch self {
        case let .getGenresList(environment):
            return .requestParameters(parameters: ["api_key": environment.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        nil
    }
}
