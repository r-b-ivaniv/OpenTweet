//
//  TimelineService.swift
//
//
//  Created by Roman Ivaniv on 2024-01-27.
//

import Foundation
import ExtensionsKit

protocol TimelineServiceProtocol {
    func fetchTimeline() async throws -> TimelineModel
}

final class TimelineService: TimelineServiceProtocol {
    
    func fetchTimeline() async throws -> TimelineModel {
        let file = File.timeline
        return try Bundle.module.loadFile(
            file.rawValue,
            ofType: file.fileType,
            subdirectory: file.subdirectory,
            with: JSONDecoder.default
        )
    }
}
