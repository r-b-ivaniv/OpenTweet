//
//  TweetCell.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import UIKit

final class TweetCell: UICollectionViewCell {
    static let reuseIdentifier = "TweetCell"
    
    lazy private var avatarImageView = UIImageView {
        $0.layer.cornerRadius = Constants.avatarSize / 2
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        
        $0.backgroundColor = .yellow
        
        addSubview($0)
    }
    
    lazy private var authorLabel = UILabel {
        $0.textColor = .red
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        
        $0.backgroundColor = .green
        
        addSubview($0)
    }
    
    lazy private var dateLabel = UILabel {
        $0.textColor = .lightGray
        $0.numberOfLines = 1
        $0.lineBreakMode = .byWordWrapping
        
        $0.backgroundColor = .systemPink

        addSubview($0)
    }
    
    lazy private var contentLabel = UILabel {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        
        $0.backgroundColor = .brown

        addSubview($0)
    }
    
    lazy private var separatorView = UIView {
        $0.backgroundColor = .lightGray
        
        addSubview($0)
    }
    
    func configure(tweet: TweetModel) {
        authorLabel.text = tweet.author
        dateLabel.text = tweet.date
        contentLabel.text = tweet.content
        
        if let path = tweet.avatar, let url = URL(string: path) {
            // RIB - cache + placeholder
            avatarImageView.download(url: url)
        }
        
        setNeedsLayout()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
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

        contentLabel.pin
            .below(of: [avatarImageView, dateLabel], aligned: .left)
            .right(Constants.inset)
            .marginTop(Constants.inset)
            .sizeToFit(.width)
        
        separatorView.pin
            .below(of: contentLabel)
            .marginTop(Constants.inset)
            .height(Constants.separatorSize)
            .horizontally()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return autoSizeThatFits(size, layoutClosure: layout)
    }
}

extension TweetCell {
    // MARK: - Nested Objects
    enum Constants {
        static let inset: CGFloat = 8
        static let avatarSize: CGFloat = 50
        static let separatorSize: CGFloat = 1
    }
 
}

