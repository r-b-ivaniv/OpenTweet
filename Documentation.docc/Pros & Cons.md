# Pros & Cons


## I'd like to share my thoughts on what I believe went well and areas I see for improvement. Spoiler alert: given more time, I could have enhanced certain aspects :)


# Pros:

1. **Multimodular Architecture:** Enhances scalability and improves parallel development. Explored the app with a perspective similar to Twitter.

2. **Efficient UI Layout:** Avoided using storyboards, XIB, autolayout, and UIStackViews (known to be slow). Instead, used the third-party library PinLayout (https://github.com/layoutBox/PinLayout, check the performance section).

3. **Efficient Cell Height Calculation:** Optimized cell height calculation using cell prototypes and manual calculations for better performance.

4. **Efficient Connection and Sorting of Tweets:** Utilized a constant dictionary (tweetMap) to efficiently connect and sort tweets on the fly.

5. **Efficient Image Loading + Cache:** Implemented efficient mechanisms for image loading and caching to enhance the overall performance of the app.

6. **UIViewController Screens with UICollectionView:** Provided more flexibility and customization opportunities. Implemented a custom complex animation, although I couldn't finish it due to time constraints.

7. **Handled Light/Dark Modes and Accessibility Edge Cases:** Ensured the app works well in different modes and considers accessibility scenarios.

8. **Added Unit Tests:** Created unit tests for core logic, specifically in TimelineViewModelTests.

9. **Error Handling:** Implemented error handling for edge cases to enhance the app's robustness.

10. **Maintained PRs for Each Task:** Maintained a clear and organized Git history with 7 pull requests, meeting both minimum and bonus requirements.

11. **Fixed Launch Image Performance Problem:** Resolved a significant performance issue related to the launch image by reducing its resolution.

# Cons:

1. **Super Simple UI:** Designed a minimalist UI without custom fonts, complex animations, etc.

2. **No Snapshot Testing:** Did not implement snapshot testing for screens.

3. **Simple Scale Animation for Cell Selection:** Implemented a basic scale animation for cell selection, without parallax or UIDynamics effects. Needed more time for additional enhancements.

4. **No Custom Transition Animation for Tweet Details:** Did not include a custom transition animation for tweet details. For instance, a custom transition layer to resize the selected tweet, slide it to the top, and show replies below. This feature required more time for implementation.

## Ideas:

- in real world for twitter like data structre core data/SwiftData could be a great fit (relationships, effiecient)
- Using swiftUI could give good performance boost for development
