//
//  FlowCoordinator.swift
//  MovieDatabaseApi
//
//  Created by Val Bratkevich on 29.03.2022.
//

import Foundation

protocol IFlowCoordinator: AnyObject {
    func start(animated: Bool)
    func finish(animated: Bool, completion: (() -> Void)?)
}

extension IFlowCoordinator {
    func finish(animated: Bool) {
        finish(animated: animated, completion: nil)
    }
}
