//
//  ViewController.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import UIKit

public protocol ViewController: UIViewController {
    associatedtype T

    var viewModel: T { get set }

    init(viewModel: T)
}
