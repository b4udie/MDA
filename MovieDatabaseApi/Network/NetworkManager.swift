//
//  NetworkManager.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation
import Moya

protocol INetworkService {
    
    func sendRequest<Response: Decodable>(
        target: TargetType,
        progressBlock: ProgressBlock?,
        decoder: JSONDecoder?,
        completion: @escaping (Result<Response, Error>) -> Void
    )
    
    func sendRequest<Response: Decodable>(
        target: TargetType,
        decoder: JSONDecoder?,
        completion: @escaping (Result<Response, Error>) -> Void
    )
    
    func sendRequest<Response: Decodable>(
        target: TargetType,
        completion: @escaping (Result<Response, Error>) -> Void
    )
}

final class NetworkService {
    
    private var provider: MoyaProvider<MultiTarget>!
    
    init(
        isNetworkLoggingEnabled: Bool,
        plugins: [PluginType] = []
    ) {
        var plugins: [PluginType] = defaultPlugins(isNetworkLoggerEnabled: isNetworkLoggingEnabled)
        plugins.append(contentsOf: plugins)
        
        provider = MoyaProvider<MultiTarget>(plugins: plugins)
    }
}

// MARK: Private methods

private extension NetworkService {
    func defaultPlugins(
        isNetworkLoggerEnabled: Bool
    ) -> [PluginType] {
        var plugins: [PluginType] = []

        if isNetworkLoggerEnabled {
            let networkLoggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
            plugins.append(networkLoggerPlugin)
        }

        return plugins
    }
    
    func parseData<Response: Decodable>(
        response: Moya.Response,
        decoder: JSONDecoder? = nil,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        do {
            let decodedResponse = try (decoder ?? JSONDecoder()).decode(Response.self, from: response.data)
            completion(.success(decodedResponse))
        } catch {
            completion(.failure(error))
        }
    }
}

// MARK: INetworkManager

extension NetworkService: INetworkService {
    func sendRequest<Response: Decodable>(
        target: TargetType,
        progressBlock: ProgressBlock?,
        decoder: JSONDecoder?,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        provider.request(
            MultiTarget(target),
            progress: progressBlock
        ) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(response):
                self.parseData(response: response, decoder: decoder, completion: completion)

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func sendRequest<Response: Decodable>(
        target: TargetType,
        decoder: JSONDecoder?,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        sendRequest(target: target, progressBlock: nil, decoder: decoder, completion: completion)
    }
    
    func sendRequest<Response: Decodable>(
        target: TargetType,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        sendRequest(target: target, progressBlock: nil, decoder: nil, completion: completion)
    }
}
