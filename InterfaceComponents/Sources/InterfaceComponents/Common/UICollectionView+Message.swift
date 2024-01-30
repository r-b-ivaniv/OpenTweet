//
//  UICollectionView+Message+Messagee.swift
//
//
//  Created by Roman Ivaniv on 2024-01-29.
//

import UIKit
import ExtensionsKit

public  extension UICollectionView {
    func setMessage(_ message: String) {
        backgroundView = UILabel {
            $0.text = message
            $0.numberOfLines = 0
            $0.textColor = .label
            $0.textAlignment = .center
            
            $0.sizeToFit()
        }
    }
    
    func clearMessage() {
        backgroundView = nil
    }
}
