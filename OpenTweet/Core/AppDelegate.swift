//
//  AppDelegate.swift
//  OpenTweet
//
//  Created by Olivier Larivain on 9/30/16.
//  Copyright © 2016 OpenTable, Inc. All rights reserved.
//

import UIKit
import Timeline

/* Ideas:
 
 1. Unit+snapshot tests
 2. Improve launch speed (try to smooth launch without loading, WWDC)
 3. PinLayout for UI performace
 4. UICollectionView instead table (more flexibility)
 5. Error handling
 6. Custom animation
 7. No xibs, storyboards
 
 
TBD:
MVP vs MVVM
 
 
*/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let flowCoordinator = TimelineFlowCoordinator()
        flowCoordinator.start()
        
		return true
	}

}

