//
//  SudokuBoard.swift
//  Sudoku
//
//  Created by PJ COOK on 14/02/2020.
//  Copyright © 2020 Software101. All rights reserved.
//

import Foundation

struct SudokuBoard {
    
    enum Errors: Error {
        case invalidBoardSize
        case invalidPoint
        case invalidValue
    }
    
    private let boardWidth = 9
    private let gridWidth = 3
    private(set) var board: [Int]
    var isSolved: Bool {
        return board.reduce(true) { $0 && $1 != 0 }
    }
    
    init(_ board: [[Int]]) throws {
        var newBoard = [Int]()
        board.forEach { line in
            line.forEach { newBoard.append($0) }
        }
        if newBoard.count != (boardWidth * boardWidth) { throw Errors.invalidBoardSize }
        self.board = newBoard
    }
    
    func row(_ index: Int) -> [Int] {
        let startIndex = rowStartIndex(index)
        return (startIndex..<startIndex + boardWidth).map { board[$0] }
    }
    
    private func rowStartIndex(_ row: Int) -> Int {
        return row * boardWidth
    }
    
    func column(_ index: Int) -> [Int] {
        var index = index
        var results = [Int]()
        while index < board.count {
            results.append(board[index])
            index += boardWidth
        }
        return results
    }
    
    func grid(_ point: Point) -> [Int] {
        var grid = Point(x: point.x / gridWidth, y: point.y / gridWidth)
        grid = Point(x: grid.x*gridWidth, y: grid.y*gridWidth)
        
        let points = [
            Point(x: grid.x, y: grid.y),
            Point(x: grid.x+1, y: grid.y),
            Point(x: grid.x+2, y: grid.y),
            Point(x: grid.x, y: grid.y+1),
            Point(x: grid.x+1, y: grid.y+1),
            Point(x: grid.x+2, y: grid.y+1),
            Point(x: grid.x, y: grid.y+2),
            Point(x: grid.x+1, y: grid.y+2),
            Point(x: grid.x+2, y: grid.y+2),
        ]
        
        return points.map { board[index($0)] }
    }
    
    private func index(_ point: Point) -> Int {
        return (point.y * boardWidth) + point.x
    }
    
    mutating func set(_ point: Point, value: Int) throws {
        guard point.y < board.count, point.x < boardWidth else { throw Errors.invalidPoint }
        guard isValidInput(value) else { throw Errors.invalidValue }
        board[index(point)] = value
    }
    
    private func isValidInput(_ value: Int) -> Bool {
        return [0,1,2,3,4,5,6,7,8,9].contains(value)
    }
    
    func findEmpty() -> [Point] {
        return board.enumerated().compactMap {
            $0.element == 0 ? point($0.offset) : nil
        }
    }
    
    private func point(_ index: Int) -> Point {
        let x = index % boardWidth
        let y = (index - x) / boardWidth
        return Point(x: x, y: y)
    }
}

extension SudokuBoard: CustomDebugStringConvertible {
    var debugDescription: String {
        var finalOutput = "-------------------\n"

        let board = self.board.chunked(into: boardWidth)

        var row = 0
        for line in board {
            row += 1
            var output = "|"
            var column = 0
            for item in line {
                column += 1
                output += String(item)
                if column % 3 == 0, column < line.count {
                    output += "|"
                } else if column < line.count {
                    output += ","
                }
            }
            output += "|"
            finalOutput += output + "\n"
            if row % 3 == 0 {
                finalOutput += "-------------------\n"
            }
        }
        return finalOutput
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
