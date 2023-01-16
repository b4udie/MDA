//
//  NavigationController.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 30.03.2022.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        navigationBar.barStyle = .black
    }
}
