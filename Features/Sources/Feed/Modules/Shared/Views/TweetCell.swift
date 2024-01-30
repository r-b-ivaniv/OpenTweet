//
//  TweetCell.swift
//
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import UIKit
import PinLayout
import ExtensionsKit
import InterfaceComponents

final class TweetCell: UICollectionViewCell {
    
    var onSelectionDone: Completion?
    
    override var isSelected: Bool {
        didSet {
            if isSelected != oldValue {
                animateSelection(isSelected)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.transform = .identity
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    lazy private var avatarImageView = UIImageView {
        $0.layer.cornerRadius = Constants.avatarSize / 2
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .systemGray
        $0.layer.masksToBounds = true
                
        // just plain image, no need accessibility
        $0.isAccessibilityElement = false

        addSubview($0)
    }
    
    lazy private var authorLabel = UILabel {
        $0.lineBreakMode = .byWordWrapping
        $0.textColor = .systemRed
        $0.numberOfLines = 0
        
        $0.accessibilityTraits = .header
                
        addSubview($0)
    }
    
    lazy private var dateLabel = UILabel {
        $0.textColor = .systemGray
        $0.numberOfLines = 1
        
        addSubview($0)
    }
        
    lazy private var contentTextView = HighlightingTextView {
        $0.textColor = .label
        $0.isEditable = false
        $0.isSelectable = true
        $0.highlight = .username
        $0.isScrollEnabled = false
        $0.dataDetectorTypes = [.link]
        $0.isUserInteractionEnabled = false
        
        addSubview($0)
    }
    
    lazy private var separatorView = UIView {
        $0.backgroundColor = .lightGray
        
        addSubview($0)
    }

    func configure(tweet: TweetModel) {
        authorLabel.text = tweet.author
        dateLabel.text = tweet.date.iso8601FormattedDate()
        contentTextView.text = tweet.content
        
        if let path = tweet.avatar, let url = URL(string: path) {
            // TODO: to get better performance we could sned request in willDisplayCell method
            avatarImageView.loadImage(from: url as NSURL)
        }
        
        setNeedsLayout()
    }
    
    private func animateSelection(_ isSelected: Bool) {
        // TODO: in real world custom animation transition to TweetViewController
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            self?.transform = isSelected ? CGAffineTransform(scaleX: Constants.scale, y: Constants.scale) : .identity
        }, completion: { [weak self] _ in
            if !isSelected {
                self?.transform = .identity
            } else {
                self?.onSelectionDone?()
            }
        })
    }
    
    private func layout() {
        avatarImageView.pin
            .left(Constants.inset)
            .top(Constants.inset)
            .height(Constants.avatarSize)
            .width(Constants.avatarSize)
        
        authorLabel.pin
            .after(of: avatarImageView)
            .marginLeft(Constants.inset)
            .top(Constants.inset)
            .right(Constants.inset)
            .sizeToFit(.width)
        
        dateLabel.pin
            .below(of: authorLabel, aligned: .left)
            .right(Constants.inset)
            .sizeToFit(.width)

        contentTextView.pin
            .below(of: [avatarImageView, dateLabel], aligned: .left)
            .right(Constants.inset)
            .marginTop(Constants.inset)
            .sizeToFit(.width)
        
        separatorView.pin
            .below(of: contentTextView)
            .marginTop(Constants.inset)
            .height(Constants.separatorSize)
            .horizontally()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return autoSizeThatFits(size, layoutClosure: layout)
    }
}

extension TweetCell {
    // MARK: - Constants
    enum Constants {
        static let inset: CGFloat = 12
        static let scale: CGFloat = 1.05
        static let avatarSize: CGFloat = 50
        static let separatorSize: CGFloat = 1
        static let animationDuration: CGFloat = 0.5
    }
}
