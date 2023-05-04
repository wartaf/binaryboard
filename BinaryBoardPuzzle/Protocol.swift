//
//  Protocol.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 1/11/23.
//

import Foundation

protocol Board{
    var board: [[BoardState]] { get }
    var numRow: Int { get }
    var numCol: Int { get }
    
    func getRows(at: Int) -> [BoardState]
    func getCols(at: Int) -> [BoardState]
    func getGrid(x: Int, y: Int) -> BoardState
}

protocol BoardTally {
    func colTally(at: Int) -> [Int]
    func rowTally(at: Int) -> [Int]
    func allRowsTally() -> [[Int]]
    func allColsTally() -> [[Int]]
}

protocol BoardConcealer {
    var concealBoard: [[BoardState]] { get }
    func revealGrid(x: Int, y: Int) -> BoardState
    func getRows(at: Int) -> [BoardState]
    func getCols(at: Int) -> [BoardState]
}

protocol VisibleTally {
    func colVisibleTally(at: Int) -> [Bool]
}

enum BoardState {
    case off, on, crossOutDefault, crossOutFail, hidden
}

extension Sequence {
    func tally<T: Equatable>(valueToTally: T) -> [Int] where T == Self.Element {
        var tally: [Int] = []
        var prv: T = valueToTally
        self.forEach { i in
            if i == valueToTally {
                if prv != valueToTally || tally.count == 0 {
                    tally.append(0)
                }
                tally[tally.endIndex - 1] += 1
            }
            prv = i
        }
        if tally.isEmpty { tally = [0] }
        return tally
    }
    
    func multiDimension() where Self.Element: Sequence {
        print(self)
    }
    
    func tallyCounter<T: Equatable>() -> [TallyItem<T>] where T == Self.Element, Self: Sequence {
        var oldVal: T?
        var stack: [TallyItem<T>] = [] // (Value,Count)
        var offset = 0
        
        self.forEach{ v in
            if stack.count == 0 || oldVal != v {
                stack.append(.init(value: v, offset: offset, count: 0))
            }
            stack[stack.endIndex - 1].count += 1
            oldVal = v
            offset += 1
        }
        return stack
    }
}

struct TallyItem <T> {
    var value: T
    var offset: Int
    var count: Int
}


extension Board {
    func getRows(at: Int) -> [BoardState] {
        board[at]
    }
    
    func getCols(at: Int) -> [BoardState] {
        board.map { $0[at] }
    }
    
    func getGrid(x: Int, y: Int) -> BoardState {
        board[y][x]
    }
    
    func rowTally(at: Int) -> [Int] {
        self.getRows(at: at)
            .tally(valueToTally: .on)
    }
    
    func colTally(at: Int) -> [Int] {
        self.getCols(at: at)
            .tally(valueToTally: .on)
    }
}

struct BinaryBoard: Board {
    var numRow: Int { board.count }
    var numCol: Int { board[0].count }
    var board: [[BoardState]]
}
