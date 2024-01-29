//
//  File.swift
//  
//
//  Created by Roman Ivaniv on 2024-01-27.
//

import Foundation

public enum BundleLoadingError: Error {
    case missingFile
}

public extension Bundle {
    func loadFile<T: Decodable>(
        _ name: String,
        ofType ext: String,
        subdirectory: String? = nil,
        with decoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        let url = try url(forResource: name, withExtension: ext, subdirectory: subdirectory).orThrow(BundleLoadingError.missingFile)
        let data = try Data(contentsOf: url)
        let result = try decoder.decode(T.self, from: data)
        return result
    }
}
