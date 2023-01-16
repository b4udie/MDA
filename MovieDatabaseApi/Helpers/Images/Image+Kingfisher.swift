//
//  Image+Kingfisher.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with imageURL: URL?) {
        kf.setImage(with: imageURL)
    }
    
    func cancelDownloadTask() {
        kf.cancelDownloadTask()
    }
}
