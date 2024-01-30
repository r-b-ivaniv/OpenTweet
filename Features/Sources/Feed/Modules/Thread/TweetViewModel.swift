//
//  ThreadViewModel.swift
//
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import Foundation
import CoreModule

protocol ThreadViewModelProtocol: ViewModel {
    var tweet: TweetModel { get }
}

final class ThreadViewModel: ThreadViewModelProtocol {
    
    let tweet: TweetModel
    
    init(tweet: TweetModel) {
        self.tweet = tweet
    }
}
