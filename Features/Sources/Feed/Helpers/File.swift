//
//  File.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-27.
//

import Foundation

enum File: String {
    case timeline

    var fileType: String {
        switch self {
        case .timeline:
            return "json"
        }
    }

    var subdirectory: String? {
        switch self {
        case .timeline:
            return "Files"
        }
    }
}
