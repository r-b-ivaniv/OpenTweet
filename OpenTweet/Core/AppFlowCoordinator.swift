//
//  AppFlowCoordinator.swift
//  OpenTweet
//
//  Created by Roman Ivaniv on 2024-01-27.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit
import Timeline
import ExtensionsKit

final class AppFlowCoordinator {
    
    let window: UIWindow
    
    lazy var navigationController = UINavigationController {
        $0.modalTransitionStyle = .crossDissolve
        $0.modalPresentationStyle = .fullScreen
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let timelineFlowCoordinator = TimelineFlowCoordinator(rootViewController: navigationController)
        timelineFlowCoordinator.start()        
    }
    
    func dismiss() {
        window.rootViewController = nil
        window.resignKey()
    }
}
