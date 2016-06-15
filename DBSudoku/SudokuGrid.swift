//
//  SudokuGrid.swift
//  DBSudoku
//
//  Created by Daniel Beard on 8/1/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

import Foundation

struct SudokuGrid {
    
    let cols = 9
    let rows = 9
    
    var matrix:[Int?]
    
    init(defaultValue:Int?) {
        matrix = Array(repeating: defaultValue, count: cols*rows)
    }
    
    subscript(col:Int, row:Int) -> Int? {
        get {
            return matrix[cols * row + col]
        }
        set {
            matrix[cols * row + col] = newValue
        }
    }
    
    //MARK: Sudoku Grid Access
    
    func valuesInRow(_ row: Int) -> [Int] {
        var result = [Int]()
        for column in 0..<cols {
            if let value = self[column, row] {
                result.append(value)
            }
        }
        return result
    }
    
    func valuesInColumn(_ column: Int) -> [Int] {
        var result = [Int]()
        for row in 0..<rows {
            if let value = self[column, row] {
                result.append(value)
            }
        }
        return result
    }
    
    func valuesInCurrentCell(_ column: Int, row: Int) -> [Int] {
        var result = [Int]()
        let startXIndex = 3 * (Int(ceil(Double(column+1) / 3.0)) - 1)
        let startYIndex = 3 * (Int(ceil(Double(row+1) / 3.0)) - 1)
        for x in startXIndex..<(startXIndex+3) {
            for y in startYIndex..<(startYIndex+3) {
                if let value = self[x, y] {
                    result.append(value)
                }
            }
        }
        return result
    }
    
    func isGridFull() -> Bool {
        for x in 0..<cols {
            for y in 0..<rows {
                if self[x, y] == nil {
                    return false
                }
            }
        }
        return true
    }
    
    func nextEmptyCellIndex() -> (col: Int, row: Int) {
        for x in 0..<cols {
            for y in 0..<rows {
                if self[x, y] == nil {
                    return (x,y)
                }
            }
        }
        return (-1, -1)
    }
    
    func validValuesAtIndex(_ col: Int, row: Int) -> [Int] {
        let values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let existingValues = valuesInColumn(col) + valuesInRow(row) + valuesInCurrentCell(col, row: row)
        return values.filter { existingValues.contains($0) == false }
    }
}

//MARK: Debug Printable
extension SudokuGrid : CustomStringConvertible {
    
    var description: String {
        var result = ""
        for row in 0..<rows {
            for column in 0..<cols {
                if let value = self[column, row] {
                    result = "\(result) \(value) ,"
                } else {
                    result = "\(result)   ,"
                }
                if (column + 1) % 3 == 0 {
                    result = "\(result) | "
                }
            }
            result = "\(result)\n"
            if (row + 1) % 3 == 0 {
                result = "\(result)--------------------------------------------\n"
            }
        }
        return result
    }
}

// Game Operations
extension SudokuGrid {
    static func solve(_ grid: inout SudokuGrid) -> Bool {
        if grid.isGridFull() {
            return true
        } else {
            let nextIndex = grid.nextEmptyCellIndex()
            for possibleValue in grid.validValuesAtIndex(nextIndex.col, row: nextIndex.row) {
                grid[nextIndex.col, nextIndex.row] = possibleValue
                if solve(&grid) {
                    return true
                }
                grid[nextIndex.col, nextIndex.row] = nil
            }
        }
        return false
    }
}

