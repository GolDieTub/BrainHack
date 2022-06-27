//
//  SudokuClass.swift
//  BrainHack
//
//  Created by Uladzimir on 17.06.2022.
//

import Foundation
import UIKit

struct sudokuData: Codable {
    var gameDiff: String = "simple"              
    var plistPuzzle: [[Int]] = [[Int]] (repeating: [Int] (repeating: 0, count: 9), count: 9)
    var pencilPuzzle: [[[Bool]]] = [[[Bool]]] (repeating: [[Bool]] (repeating: [Bool] (repeating: false, count: 10), count: 9), count: 9)
    var userPuzzle: [[Int]] = [[Int]] (repeating: [Int] (repeating: 0, count: 9), count: 9)


class sudokuClass {
    var inProgress = false
    var grid: sudokuData! = sudokuData()

    func numberAt(row : Int, column : Int) -> Int {
        if grid.plistPuzzle[row][column] != 0 {
            return grid.plistPuzzle[row][column]
        } else {
            return grid.userPuzzle[row][column]
        }
    }

    func numberIsFixedAt(row : Int, column : Int) -> Bool {
        if grid.plistPuzzle[row][column] != 0 {
            return true
        } else {
            return false
        }
    }
    
    func endOfTheGame() -> Bool{
        var conflict = true
        for r in 0...8{
            for c in 0...8{
                conflict = isConflictingEntryAt(row: r, column: c)
                if (grid.userPuzzle[r][c] == 0) || (conflict == true) {
                    if grid.plistPuzzle[r][c] == 0{
                        return false
                    }
                }
            }
        }
        return true
    }

    func isConflictingEntryAt(row : Int, column: Int) -> Bool  {
        // get n
        var n: Int
        if grid.plistPuzzle[row][column] == 0 {
            n = grid.userPuzzle[row][column]
        } else {
            n = grid.plistPuzzle[row][column]
        }
        
        // if no value exists in entry -- no conflict
        if n == 0 { return false }
        
        // check all columns - if same number as current number (except current location) -- conflict
        for r in 0...8 {
            if r != row && (grid.plistPuzzle[r][column] == n || grid.userPuzzle[r][column] == n) {
                return true;
            }
        }
        
        // check all rows - if same number as current number (except current location) -- conflict
        for c in 0...8 {
            if c != column && (grid.plistPuzzle[row][c] == n || grid.userPuzzle[row][c] == n) {
                return true;
            }
        }
        
        var minX = -1
        var maxX = -1
        var minY = -1
        var maxY = -1
        switch (row){
        case 0...2:
            switch (column){
            case 0...2:
                minX = 0
                maxX = 2
                minY = 0
                maxY = 2
            case 3...5:
                minX = 0
                maxX = 2
                minY = 3
                maxY = 5
            case 6...8:
                minX = 0
                maxX = 2
                minY = 6
                maxY = 8
            default:
                print("Error")
            }
        case 3...5:
            switch (column){
            case 0...2:
                minX = 3
                maxX = 5
                minY = 0
                maxY = 2
            case 3...5:
                minX = 3
                maxX = 5
                minY = 3
                maxY = 5
            case 6...8:
                minX = 3
                maxX = 5
                minY = 6
                maxY = 8
            default:
                print("Error")
            }
        case 6...8:
            switch (column){
            case 0...2:
                minX = 6
                maxX = 8
                minY = 0
                maxY = 2
            case 3...5:
                minX = 6
                maxX = 8
                minY = 3
                maxY = 5
            case 6...8:
                minX = 6
                maxX = 8
                minY = 6
                maxY = 8
            default:
                print("Error")
            }
        default:
            print("Error")
        }
        
        for r in minX...maxX {
            for c in minY...maxY {
                // if not the original square and contains the value n -- conflict
                if c != column && r != row && (grid.plistPuzzle[r][c] == n || grid.userPuzzle[r][c] == n) {
                    return true
                } // end if
            } // end c
        } // end r
        
        // no conflicts
        return false
    }

    func anyPencilSetAt(row : Int, column : Int) -> Bool {
        for n in 0...8 {
            if grid.pencilPuzzle[row][column][n] == true {
                return true
            }
        }
        return false
    }
        
    func isSetPencil(n : Int, row : Int, column : Int) -> Bool {
        return grid.pencilPuzzle[row][column][n]
    }
    
    func plistToPuzzle(plist: String, toughness: String) -> [[Int]] {
        var puzzle = [[Int]] (repeating: [Int] (repeating: 0, count: 9), count: 9)
        let plistZeroed = plist.replacingOccurrences(of: ".", with: "0")
        
        var col: Int = 0
        var row: Int = 0
        for c in plistZeroed {
            puzzle[row][col] = Int(String(c))!
            row = row + 1
            if row == 9 {
                row = 0
                col = col + 1
                if col == 9 {
                    return puzzle
                }
            }
        }
        
        return puzzle
    }
    
    func userGrid(n: Int, row: Int, col: Int) {
        grid.userPuzzle[row][col] = n
    }

    func userEntry(row: Int, column: Int) -> Int {
        return grid.userPuzzle[row][column]
    }
    

    func pencilGrid(n: Int, row: Int, col: Int) {
        grid.pencilPuzzle[row][col][n] = !grid.pencilPuzzle[row][col][n]
    }


    func pencilGridBlank(n: Int, row: Int, col: Int) {
        grid.pencilPuzzle[row][col][n] = false
    }
    
    func clearPlistPuzzle() {
        grid.plistPuzzle = [[Int]] (repeating: [Int] (repeating: 0, count: 9), count: 9) // the loaded puzzle
    }
    
    func clearPencilPuzzle() {
        grid.pencilPuzzle = [[[Bool]]] (repeating: [[Bool]] (repeating: [Bool] (repeating: false, count: 10), count: 9), count: 9)
    }
    
    func clearUserPuzzle() {
        grid.userPuzzle = [[Int]] (repeating: [Int] (repeating: 0, count: 9), count: 9)
    }
    
    func clearConflicts() {
        for r in 0...8 {
            for c in 0...8 {
                if isConflictingEntryAt(row: r, column: c) {
                    grid.userPuzzle[r][c] = 0
                }
            }
        }
    }
    
    func gameInProgress(set: Bool) {
        inProgress = set
    }

}

