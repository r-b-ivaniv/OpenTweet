//
//  File.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-27.
//

import Foundation

struct TimelineModel: Codable {
    let timeline: [TweetModel]
}

struct TweetModel: Codable {
    let id: String
    let author: String
    let content: String
    let date: String
    let avatar: String?
    let inReplyTo: String?
}
