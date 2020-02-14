import XCTest
@testable import Sudoku

class SudokuTests: XCTestCase {

    func test_readSampleData() throws {
        let board = try SudokuFileReader.read("Sample1.data", bundle: Bundle(for: SudokuTests.self))
        
        XCTAssertEqual(81, board.board.count)
    }

    func test_sample1_solve() throws {
        let board = try SudokuFileReader.read("Sample1.data", bundle: Bundle(for: SudokuTests.self))
        let result = try SudokuSolver().solve(board)
        XCTAssertTrue(result.isSolved)
    }
    
    func test_Impossible_solve() throws {
        let board = try SudokuFileReader.read("Impossible.data", bundle: Bundle(for: SudokuTests.self))
        let result = try SudokuSolver().solve(board)
        XCTAssertFalse(result.isSolved)
    }
    
    func test_Hard_solve() throws {
        let board = try SudokuFileReader.read("Hard.data", bundle: Bundle(for: SudokuTests.self))
        let result = try SudokuSolver().solve(board)
        print("Solution", result)
        XCTAssertTrue(result.isSolved)
    }
    
    func test_MultipleSolutions_solve() throws {
        let board = try SudokuFileReader.read("MultipleSolutions.data", bundle: Bundle(for: SudokuTests.self))
        let result = try SudokuSolver().solve(board)
        print("Solution", result)
        XCTAssertTrue(result.isSolved)
    }
    
    func test_sample1_brute() throws {
        let board = try SudokuFileReader.read("Sample1.data", bundle: Bundle(for: SudokuTests.self))
        let result = try SudokuSolver().brute(board)
        XCTAssertTrue(result.isSolved)
    }
    
    func test_Impossible_brute() throws {
        let board = try SudokuFileReader.read("Impossible.data", bundle: Bundle(for: SudokuTests.self))
        let result = try SudokuSolver().brute(board)
        XCTAssertFalse(result.isSolved)
    }
    
    func test_Hard_brute() throws {
        let board = try SudokuFileReader.read("Hard.data", bundle: Bundle(for: SudokuTests.self))
        let result = try SudokuSolver().brute(board)
        print("Solution", result)
        XCTAssertTrue(result.isSolved)
    }
    
    func test_MultipleSolutions_brute() throws {
        let board = try SudokuFileReader.read("MultipleSolutions.data", bundle: Bundle(for: SudokuTests.self))
        let result = try SudokuSolver().brute(board)
        print("Solution", result)
        XCTAssertTrue(result.isSolved)
    }
}
