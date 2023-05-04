//
//  Board.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/20/23.
//

import Foundation

enum NonoGridType: Int {
    case none = 0
    case black = 1
    case boxRed = 2
    case crossRed = 3
    case cross = 4
}

struct NonoBoard {
    private let board: [[Bool]]
    
    var fullGraph: [[NonoGridType]] {
        [[]]
    }
    
    func trigger(_ grid: CGPoint) { }
    
    func getRow(at: Int) -> [NonoGridType] {
        []
    }
    
    func getCol(at: Int) -> [NonoGridType] {
        []
    }
    
      
}
