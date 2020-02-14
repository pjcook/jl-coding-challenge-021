//
//  PuzzleReader.swift
//  Sudoku
//
//  Created by PJ COOK on 14/02/2020.
//  Copyright © 2020 Software101. All rights reserved.
//

import Foundation

enum SudokuFileReader {
    static func read(_ filename: String, bundle: Bundle) throws -> SudokuBoard {
        let input = try readInput(filename: filename, delimiter: "\n", cast: String.init, bundle: bundle)
        var puzzleInput = [[Int]]()
        for line in input {
            let data = line.split(separator: ",").compactMap { Int(String($0)) }
            puzzleInput.append(data)
        }
        return try SudokuBoard(puzzleInput)
    }
}
