//
//  AppStoryboard.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import UIKit

enum AppStoryboard: String {
    
    case moviesList = "MoviesList"
    case movieDetails = "MovieDetails"

    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiateFrom(appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
