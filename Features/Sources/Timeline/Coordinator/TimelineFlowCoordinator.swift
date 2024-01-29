//
//  TimelineFlowCoordinator.swift
//
//
//  Created by Roman Ivaniv on 2024-01-26.
//

import UIKit

public final class TimelineFlowCoordinator {
    
    public unowned let rootViewController: UINavigationController
    
    public init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    public func start() {
        let timelineController = TimelineViewController(
            viewModel: TimelineViewModel(
                timelineService: TimelineService()
            )
        )
        rootViewController.viewControllers = [timelineController]
    }
}
