//
//  SceneDelegate.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var rootFlowCoordinator: IFlowCoordinator = RootFlowCoordinator(
        resolver: (UIApplication.shared.delegate as? AppDelegate)?.resolver,
        window: window
    )

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil else { return }
        
        rootFlowCoordinator.start(animated: false)
    }
}
