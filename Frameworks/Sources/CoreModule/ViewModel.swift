//
//  ViewModel.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-28.
//

import Foundation

public protocol ViewModel {
    func setup()
    func update()
}
public extension ViewModel {
    func setup() { }
    func update() { }
}
