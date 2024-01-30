//
//  Coordinator.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import UIKit

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start(animated: Bool)
}
