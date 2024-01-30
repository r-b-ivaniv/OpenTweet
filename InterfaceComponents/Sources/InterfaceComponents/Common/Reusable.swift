//
//  File.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import UIKit

public protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: Reusable { }


public extension UICollectionView {
    /**
     
     Regiser UICollectionViewCell from class.
     
     ### Usage Example: ###
     ````
     collectionView.register(CardCollectionViewCell.self)
     ````
     
     - Parameter cellType: Cell which should be registered.
     */
    func register(_ cellType: Reusable.Type...) {
        for cellType in cellType {
            register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    func registerSupplementaryView(_ viewType: Reusable.Type, king: String) {
        register(viewType, forSupplementaryViewOfKind: king, withReuseIdentifier: viewType.reuseIdentifier)
    }
    
    /**
     
     Returns reused UICollectionViewCell casted to reusable type.
     Used together with Configurable and Delegating protocols.
     
     ### Usage Example: ###
     ````
     collectionView
         .dequeueReusableCell(withType: CardCollectionViewCell.self, for: indexPath)
         .configured(with: card, delegating: self)
     ````
     
     - Parameter type: Cell type which should be reused.
     - Parameter indexPath: Reusing index path.
     - Returns: Casted to reusable type cell.
     */
    func dequeueReusableCell<T>(withType type: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            preconditionFailure("Failed to dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T>(withType type: T.Type, king: String, for indexPath: IndexPath) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: king,
            withReuseIdentifier: T.reuseIdentifier, for: indexPath
        ) as? T else {
            preconditionFailure("Failed to dequeue supplementaryView with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
}

