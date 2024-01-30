//
//  SectionHeaderView.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-29.
//

import UIKit
import PinLayout

final class SectionHeaderView: UICollectionReusableView {

    lazy private var headerLabel = UILabel {
        $0.textColor = .label
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
                
        addSubview($0)
    }

    func configure(header: String?) {
        headerLabel.text = header
        backgroundColor = .systemGray
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        headerLabel.pin.all(Constants.inset)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return autoSizeThatFits(size, layoutClosure: layout)
    }
}

extension SectionHeaderView {
    // MARK: - Constants
    enum Constants {
        static let inset: CGFloat = 8
    }
}
