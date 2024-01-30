//
//  AppFlowCoordinator.swift
//  OpenTweet
//
//  Created by Roman Ivaniv on 2024-01-27.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit
import Feed
import CoreModule
import ExtensionsKit

final class AppFlowCoordinator: Coordinator {
    
    let window: UIWindow
    
    var childCoordinators = [Coordinator]()

    lazy var navigationController = UINavigationController {
        $0.modalTransitionStyle = .crossDissolve
        $0.modalPresentationStyle = .fullScreen
    }
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start(animated: Bool) {
        let feedFlowCoordinator = FeedFlowCoordinator(navigationController: navigationController)
        feedFlowCoordinator.start(animated: animated)
        
        childCoordinators.append(feedFlowCoordinator)
    }
    
    func dismiss() {
        window.rootViewController = nil
        window.resignKey()
    }
}
