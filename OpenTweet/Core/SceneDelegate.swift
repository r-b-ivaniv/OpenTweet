//
//  SceneDelegate.swift
//  OpenTweet
//
//  Created by Roman Ivaniv on 2024-01-27.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appFlowCoordinator: AppFlowCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            preconditionFailure("UIWindowScene missing")
        }
        
        let window = UIWindow(windowScene: windowScene)
        
        appFlowCoordinator = AppFlowCoordinator(window: window)
        appFlowCoordinator?.start()
    }
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}
