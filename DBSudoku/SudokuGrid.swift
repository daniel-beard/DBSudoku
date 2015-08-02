//
//  SudokuGrid.swift
//  DBSudoku
//
//  Created by Daniel Beard on 8/1/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

import Foundation

struct SudokuGrid : SequenceType, GeneratorType {
    
    let cols = 9
    let rows = 9
    
    var matrix:[Int?]
    
    init(defaultValue:Int?) {
        matrix = Array(count:cols*rows, repeatedValue:defaultValue)
    }
    
    subscript(col:Int, row:Int) -> Int? {
        get {
            return matrix[cols * row + col]
        }
        set {
            matrix[cols * row + col] = newValue
        }
    }
    
    func colCount() -> Int {
        return self.cols
    }
    
    func rowCount() -> Int {
        return self.rows
    }
    
    //MARK: Sudoku Grid Access
    
    func valuesInRow(row: Int) -> [Int] {
        var result = [Int]()
        for column in 0..<cols {
            if let value = self[column, row] {
                result.append(value)
            }
        }
        return result
    }
    
    func valuesInColumn(column: Int) -> [Int] {
        var result = [Int]()
        for row in 0..<rows {
            if let value = self[column, row] {
                result.append(value)
            }
        }
        return result
    }
    
    func valuesInCurrentCell(column: Int, row: Int) -> [Int] {
        var result = [Int]()
        let cellXIndex = Int(ceil(Double(column+1) / 3.0))
        let cellYIndex = Int(ceil(Double(row+1) / 3.0))
        let startXIndex = 3 * (cellXIndex - 1)
        let startYIndex = 3 * (cellYIndex - 1)
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
    
    func validValuesAtIndex(col: Int, row: Int) -> [Int] {
        var values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let columnValues = valuesInColumn(col)
        let rowValues = valuesInRow(row)
        let cellValues = valuesInCurrentCell(col, row: row)
        
        values = values.filter({columnValues.contains($0) == false}).filter({rowValues.contains($0) == false}).filter({cellValues.contains($0) == false})
        return values
    }
    
    
    //MARK: GeneratorType
    
    var currentElement = 0
    mutating func next() -> Int? {
        if currentElement < matrix.count {
            let curItem = currentElement
            currentElement++
            return matrix[curItem]
        }
        return nil
    }
    
    //MARK: SequenceType
    
    typealias Generator = SudokuGrid
    
    func generate() -> Generator {
        return self
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

