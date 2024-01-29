//
//  File.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-27.
//

import Foundation

public extension Optional {
    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            throw errorExpression()
        }
    }
}
