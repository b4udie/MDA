//
//  ImagesHelper.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import Foundation

protocol IImageHelper {
    
    func createImageURL(with imagePath: String?, quality: ImageHelper.Size) -> URL?
}

final class ImageHelper {
    
    private let networkEnvironment: INetworkEnvironment
    
    init(networkEnvironment: INetworkEnvironment) {
        self.networkEnvironment = networkEnvironment
    }
}

// MARK: IImageHelper

extension ImageHelper: IImageHelper {
        
    func createImageURL(with imagePath: String?, quality: ImageHelper.Size) -> URL? {
        guard let imagePath = imagePath else {
            return nil
        }
        
        return networkEnvironment.baseImageURL
            .appendingPathComponent(quality.quality)
            .appendingPathComponent(imagePath)
    }
}

// MARK: Qualities

extension ImageHelper {
    
    enum Size {
        enum Backdrop: String {
            case w300
            case w780
            case w1280
            case original
        }
    
        enum Poster: String {
            case w92
            case w154
            case w185
            case w342
            case w500
            case w780
            case original
        }
        
        case backdrop(Backdrop)
        case poster(Poster)
        
        var quality: String {
            switch self {
            case let .backdrop(value):
                return value.rawValue
                
            case let .poster(value):
                return value.rawValue
            }
        }
    }
}
