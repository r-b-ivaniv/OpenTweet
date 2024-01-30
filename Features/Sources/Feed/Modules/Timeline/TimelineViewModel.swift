//
//  TimelineViewModel.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-27.
//

import Foundation
import CoreModule
import ExtensionsKit

protocol TimelineViewModelProtocol: ViewModel {
    var state: TimelineViewModel.State { get }
    func didSelect(tweet: TweetModel)
}

final class TimelineViewModel: TimelineViewModelProtocol {
    enum State: Equatable {
        case loading
        case loaded(timeline: [TweetModel])
        case error(String)
    }

    @Published private(set) var state: State = .loading
    
    let timelineService: TimelineServiceProtocol
    
    var onTweetAction: Callback<TweetModel>?

    init(timelineService: TimelineServiceProtocol, onTweetAction: Callback<TweetModel>?) {
        self.timelineService = timelineService
        self.onTweetAction = onTweetAction
    }
    
    func setup() {
        loadData()
    }
    
    func didSelect(tweet: TweetModel) {
        onTweetAction?(tweet)
    }
 
    private func loadData() {
        Task(priority: .high) { [weak self] in guard let self else { return }
            do {
                let model = try await self.timelineService.fetchTimeline()

                self.connectReplies(in: model.timeline)
                
                await MainActor.run {
                    self.state = .loaded(timeline: model.timeline)
                }
            } catch {
                // TODO: in real world should be user friendly error message
                self.state = .error(error.localizedDescription)
            }
        }
    }
    
    func connectReplies(in timeline: [TweetModel]) {
        let tweetMap: [String: TweetModel] = Dictionary(uniqueKeysWithValues: timeline.map { ($0.id, $0) })

        for tweet in timeline {
            if let replyToId = tweet.inReplyTo, let replyTo = tweetMap[replyToId] {
                // Connect the replies and sort them on the fly
                replyTo.replies = (replyTo.replies ?? []) + [tweet]
                replyTo.replies?.sort { $0.date < $1.date }
                tweet.tweetReplyTo = replyTo
            }
        }
    }
}

