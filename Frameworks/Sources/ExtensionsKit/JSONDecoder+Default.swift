//
//  JSONDecoder+Default.swift
//
//
//  Created by Roman Ivaniv on 2024-01-29.
//

import Foundation

public extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
