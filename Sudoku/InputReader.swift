//
//  InputReader.swift
//  Year2019
//
//  Created by PJ COOK on 02/12/2019.
//  Copyright © 2019 Software101. All rights reserved.
//

import Foundation

public class Bundler {
    public static let bundle = Bundle(for: Bundler.self)
}

public enum InputErrors: Error {
    case invalidFilename
    case invalidFileData
}

public func readInput<T>(filename: String, delimiter: Character, cast: (String) -> T, bundle: Bundle = Bundler.bundle) throws -> [T] {
    func cleanString(_ input: String) -> String {
        return input.replacingOccurrences(of: "\n", with: "")
    }
    
    guard let url = bundle.url(forResource: filename, withExtension: nil) else {
        throw InputErrors.invalidFilename
    }
    let data = try Data(contentsOf: url)
    guard let value = String(data: data, encoding: .utf8) else {
        throw InputErrors.invalidFileData
    }
    return value.split(separator: delimiter).compactMap { cast(cleanString(String($0))) }
}
