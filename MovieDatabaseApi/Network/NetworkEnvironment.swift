//
//  NetworkEnvironment.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation

struct NetworkConfiguration: Decodable {
    let baseURL: String
    let baseImageURL: String
    let apiKey: String
}

protocol INetworkEnvironment {
    
    var baseURL: URL { get }
    var baseImageURL: URL { get }
    var apiKey: String { get }
    var apiVersion: String { get }
}

final class NetworkEnvironemt: INetworkEnvironment {
    
    private lazy var config: NetworkConfiguration = {
        guard
            let configPath = Bundle.main.path(forResource: "NetworkConfiguration", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: configPath),
            let config = try? PropertyListDecoder().decode(NetworkConfiguration.self, from: xml)
        else {
            fatalError("Can't find network configuration file")
        }
        
        return config
    }()
    
    var baseURL: URL {
        URL(string: config.baseURL)!
    }
    
    var baseImageURL: URL {
        URL(string: config.baseImageURL)!
    }
    
    var apiKey: String {
        config.apiKey
    }
    
    var apiVersion: String {
        "3"
    }
}
