//
//  File.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-27.
//

import Foundation

protocol TimelineViewModelProtocol {
    func loadData()
    
    var dataSource: [TweetModel] { get }
}

final class TimelineViewModel: TimelineViewModelProtocol {
    @MainActor @Published var dataSource: [TweetModel] = []
    
    let timelineService: TimelineServiceProtocol
    
    init(timelineService: TimelineServiceProtocol) {
        self.timelineService = timelineService
        
        loadData()
    }
    
    func loadData() {
        Task(priority: .high) { [weak self] in guard let self else { return }
            do {
                let model = try await self.timelineService.fetchTimeline()

                await MainActor.run {
                    self.dataSource = model.timeline
                }
            } catch {
                // TODO: handle error
                print(error)
            }
        }
    }
}
