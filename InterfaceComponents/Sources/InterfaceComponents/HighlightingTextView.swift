//
//  HighlightingTextView.swift
//
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import UIKit

public class HighlightingTextView: UITextView {
    public enum HighlightItem {
        case username
        case custom(prefix: String, color: UIColor)

        var color: UIColor {
            switch self {
            case .username:
                return .red
            case let .custom(_, color):
                return color
            }
        }

        var prefix: String {
            switch self {
            case .username:
                return "@"
            case let .custom(prefix, _):
                return prefix
            }
        }
    }
    
    public var highlight: HighlightItem? {
        didSet {
            updateUsernameHighlighting()
            observeTextChanges()
        }
    }

    private var textObserver: NSKeyValueObservation?

    private func observeTextChanges() {
        textObserver = observe(\.text, options: .new) { [weak self] _, _  in
            self?.updateUsernameHighlighting()
        }
    }

    private func updateUsernameHighlighting() {
        guard let config = highlight else { return }

        let usernameRegex = try? NSRegularExpression(pattern: "\(config.prefix)\\w+", options: .caseInsensitive)

        usernameRegex?.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.count)) { match, _, _ in
            if let range = match?.range(at: 0) {
                textStorage.addAttributes([.foregroundColor: config.color], range: range)
            }
        }
    }
}
