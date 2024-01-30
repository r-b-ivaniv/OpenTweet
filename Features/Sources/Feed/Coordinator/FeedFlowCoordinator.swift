//
//  FeedFlowCoordinator.swift
//
//
//  Created by Roman Ivaniv on 2024-01-26.
//

import UIKit
import CoreModule

public final class FeedFlowCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start(animated: Bool) {
        routeTimeline(animated: animated)
    }

    private func routeTimeline(animated: Bool) {
        let timelineController = TimelineViewController(
            viewModel: TimelineViewModel(
                timelineService: TimelineService(),
                onTweetAction: { [weak self] tweet in
                    self?.routeTweet(tweet)
                }
            )
        )
        
        navigationController.pushViewController(timelineController, animated: animated)
    }
    
    private func routeTweet(_ tweet: TweetModel, animated: Bool = true) {
        let tweetController = ThreadViewController(
            viewModel: ThreadViewModel(
                tweet: tweet
            )
        )
        
        navigationController.pushViewController(tweetController, animated: animated)
    }
}
