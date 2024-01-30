//
//  String+Date.swift
//
//
//  Created by Roman Ivaniv on 2024-01-29.
//

import Foundation

public extension String {
    func iso8601FormattedDate(_ format: String = "MMM d, yyyy h:mm a") -> String? {
        let dateFormatter = ISO8601DateFormatter()

        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }

        return nil
    }
}
