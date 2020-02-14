import Foundation

class SudokuSolver {
    func brute(_ board: SudokuBoard) throws -> SudokuBoard {
        guard !board.isSolved else { return board }
        var newBoard = board
        guard let tile = newBoard.findEmpty().first else { return newBoard }
        let remainingOptions = options(for: tile, board: newBoard)
        for option in remainingOptions {
            try newBoard.set(tile, value: option)
            guard !newBoard.isSolved else { return newBoard }
            let board2 = try brute(newBoard)
            if board2.isSolved { return board2 }
        }
        return newBoard
    }
    
    func solve(_ board: SudokuBoard) throws -> SudokuBoard {
        var updated = false
        guard !board.isSolved else { return board }
        var newBoard = board
        let tiles = newBoard.findEmpty()
        for tile in tiles {
            let remainingOptions = self.options(for: tile, board: newBoard)
            if remainingOptions.count == 1 {
                try newBoard.set(tile, value: remainingOptions[0])
                updated = true
            }
        }
        if !updated {
            return try brute(board)
        }
        return try solve(newBoard)
    }
    
    private func options(for tile: Point, board: SudokuBoard) -> [Int] {
        let rowItems = board.row(tile.y).compactMap { $0 != 0 ? $0 : nil }
        let columnItems = board.column(tile.x).compactMap { $0 != 0 ? $0 : nil }
        let gridItems = board.grid(tile).compactMap { $0 != 0 ? $0 : nil }
        var options = [1:false,2:false,3:false,4:false,5:false,6:false,7:false,8:false,9:false]
        rowItems.forEach {
            options[$0] = true
        }
        columnItems.forEach {
            options[$0] = true
        }
        gridItems.forEach {
            options[$0] = true
        }
        let remainingOptions = options.compactMap { $0.value == false ? $0.key : nil }
        return remainingOptions
    }
    
}
