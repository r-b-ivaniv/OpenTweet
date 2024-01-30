import XCTest
@testable import Feed

final class TimelineViewModelTests: XCTestCase {
    // TODO: more unit tests
    func testConnectReplies() async throws {
        let mockSevice = MockTimelineService()
        let viewModel = TimelineViewModel(timelineService: mockSevice, onTweetAction: nil)
        let timelineModel = try! await viewModel.timelineService.fetchTimeline()
        let tweets = timelineModel.timeline
        
        viewModel.connectReplies(in: tweets)

        let tweet1 = tweets[0]
        let tweet2 = tweets[1]
        let tweet3 = tweets[2]
        let tweet4 = tweets[3]

        XCTAssertEqual(tweet2.replies?.count, 1)
        XCTAssertEqual(tweet2.replies?.first?.id, "3")

        XCTAssertNil(tweet1.tweetReplyTo)
        XCTAssertEqual(tweet2.tweetReplyTo?.id, "1")
        XCTAssertEqual(tweet3.tweetReplyTo?.id, "2")
        XCTAssertNil(tweet4.tweetReplyTo)
    }
}

private class MockTimelineService: TimelineServiceProtocol {
    func fetchTimeline() async throws -> Feed.TimelineModel {
        // Create a sample timeline with tweets
        let tweet1 = makeTweet(id: "1", author: "Author1", content: "Tweet 1", date: "2024-01-31", avatar: "avatar1", inReplyTo: nil)
        let tweet2 = makeTweet(id: "2", author: "Author2", content: "Tweet 2", date: "2024-02-01", avatar: "avatar2", inReplyTo: "1")
        let tweet3 = makeTweet(id: "3", author: "Author3", content: "Tweet 3", date: "2024-02-02", avatar: "avatar3", inReplyTo: "2")
        let tweet4 = makeTweet(id: "4", author: "Author4", content: "Tweet 4", date: "2024-02-03", avatar: "avatar4", inReplyTo: nil)


        return TimelineModel(timeline: [tweet1, tweet2, tweet3, tweet4])
    }
    
    private func makeTweet(
        id: String,
        author: String,
        content: String,
        date: String,
        avatar: String?,
        inReplyTo: String?
    ) -> TweetModel {
        // TODO: in real world we could use different stubs file to test all ednge cases
        let jsonData = """
                {
                    "id": "\(id)",
                    "author": "\(author)",
                    "content": "\(content)",
                    "date": "\(date)",
                    "avatar": \(avatar != nil ? "\"\(avatar!)\"" : "null"),
                    "inReplyTo": \(inReplyTo != nil ? "\"\(inReplyTo!)\"" : "null")
                }
                """.data(using: .utf8)!
        
        return try! JSONDecoder().decode(TweetModel.self, from: jsonData)
    }
}
