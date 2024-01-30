//
//  UICollectionView+Message+Messagee.swift
//
//
//  Created by Roman Ivaniv on 2024-01-29.
//

import UIKit

public extension UICollectionView {
    func setMessage(_ message: String) {
        let label = UILabel()
        label.text = message
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        
        label.sizeToFit()
        backgroundView = label
    }
    
    func clearMessage() {
        backgroundView = nil
    }
}

