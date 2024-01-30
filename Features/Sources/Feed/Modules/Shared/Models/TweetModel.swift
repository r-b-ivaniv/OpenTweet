//
//  TweetModel.swift
//
//
//  Created by Roman Ivaniv on 2024-01-29.
//

import Foundation

final class TweetModel: Codable {
    let id: String
    let author: String
    let content: String
    let date: String
    let avatar: String?
    let inReplyTo: String?
    
    var tweetReplyTo: TweetModel?
    var replies: [TweetModel]?
}

extension TweetModel: Hashable {
    static func == (lhs: TweetModel, rhs: TweetModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
