//
//  SudokuGame.swift
//  DBSudoku
//
//  Created by Daniel Beard on 8/1/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

import Foundation

class SudokuGame {
    
    var grid = SudokuGrid()
    
    init() {
        setupTestGrid()
        print(grid)
        
        print(SudokuGrid.solve(&grid))
        print(grid)
    }
    
    func setupTestGrid() {
        grid[2, 0] = 1
        grid[3, 0] = 6
        grid[6, 0] = 8
        
        grid[1, 1] = 7
        grid[2, 1] = 3
        grid[3, 1] = 2
        grid[5, 1] = 5
        grid[8, 1] = 1
        
        grid[2, 2] = 4
        grid[8, 2] = 2
        
        grid[0, 3] = 5
        grid[2, 3] = 2
        grid[5, 3] = 8
        
        grid[0, 4] = 9
        grid[2, 4] = 7
        grid[3, 4] = 1
        grid[5, 4] = 2
        grid[6, 4] = 3
        grid[8, 4] = 5
        
        grid[3, 5] = 9
        grid[6, 5] = 4
        grid[8, 5] = 8
        
        grid[0, 6] = 1
        grid[6, 6] = 2
        
        grid[0, 7] = 7
        grid[3, 7] = 4
        grid[5, 7] = 3
        grid[6, 7] = 9
        grid[7, 7] = 5
        
        grid[2, 8] = 9
        grid[5, 8] = 6
        grid[6, 8] = 1
    }
    
}