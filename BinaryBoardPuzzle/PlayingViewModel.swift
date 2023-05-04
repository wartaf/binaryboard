//
//  PlayingViewModel.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/3/23.
//

import Foundation
import SwiftUI
import CoreHaptics

class PlayingViewModel: ObservableObject {
    let title: String = "GAME_TITLE"
    let board: [[Int]]
    let boardSize: Int
    //IMAGE_FINISHED_LABEL
    let uiImage: UIImage? = nil
    
    private var totalClue = 99 // this should come from appState
    
    private let totalGridCount: Int
    
    var heartRemaining: Int
    
    @Published var graph: [[NonoGridType]]
    
    private var haptic: CHHapticEngine?
    
    private var pause = false // For Disabling pressingGrid if wrong
    
    @Published var markerType: MarkerType = .black
    
    var remainingClue: Int {
        return self.totalClue
    }
    
    var remainingBlock: Int {
        let graphCount = graph.map { el in
            el.tally(valueToTally: .black)
                .reduce(0, +)
            +
            el.tally(valueToTally: .boxRed)
                .reduce(0, +)
        }
        .reduce(0, +) //Loop for(x*y) seems faster
        
        return totalGridCount - graphCount
    }

    private var dragLock = CGPoint.zero
    private var lastLocation = CGPoint.zero
    
    init(board: [[Int]]){
        self.board = board
        self.boardSize = board.count
        self.heartRemaining = 3
        self.graph = Array(repeating: Array(repeating: .none, count: self.boardSize), count: self.boardSize)
        
        self.totalGridCount = board.map { el in
            el.tally(valueToTally: 1)
                .reduce(0, +)
        }
        .reduce(0, +)
        
        //Init HapticFeedback
        haptic = myHapticPrepareHaptics()
    }
    
    func inputReceiver(_ point: CGPoint) {
        if pause { return }
        self.revealGrid(point)
    }
    
    func gestureCompute(rows: Int, cols: Int, boxPixelWidth: Double) -> some Gesture {
        let lpg = LongPressGesture(minimumDuration: 0)
            .onEnded({ b in
                self.inputReceiver((CGPoint(x: rows + 1, y: cols + 1)))
            })
            
        let dg = DragGesture(minimumDistance: 0, coordinateSpace: .named("coor"))
            .onChanged({ v in
                let gridWidth = boxPixelWidth / Double(self.boardSize)
                if v.location.x > 0 && v.location.y > 0 {
                    let locX = ceil(v.location.x / gridWidth)
                    let locY = ceil(v.location.y / gridWidth)

                    if self.dragLock == .zero && self.lastLocation != .zero {
                        if self.lastLocation.x != locX {
                            self.dragLock = .init(x: 0, y: locY)
                        } else if self.lastLocation.y != locY {
                            self.dragLock = .init(x: locX, y: 0)
                            }
                    }
                    self.lastLocation = .init(x: locX, y: locY)
                    
                    if self.dragLock != .zero {
                        if self.dragLock.x == 0 {
                            self.inputReceiver(CGPoint(x: locX, y: self.dragLock.y))
                        } else if self.dragLock.y == 0 {
                            self.inputReceiver(CGPoint(x: self.dragLock.x, y: locY))
                        } else {
                            self.inputReceiver(CGPoint(x: locX, y: locY))
                        }
                    }
                }
                
                
            })
            .onEnded({ v in
                self.lastLocation = .zero
                self.dragLock = .zero
            })
            
        return lpg.sequenced(before: dg)
    }
    
    func revealGrid(_ point: CGPoint) {

        let x = Int(point.x) - 1
        let y = Int(point.y) - 1
        
        if x < 0 || y < 0 || x >= boardSize || y >= boardSize { return }
        
        if graph[y][x] == .none {
            if markerType == .black {
                if board[y][x] == 1 {
                    self.graph[y][x] = .black
                    guess(is: .correct)
                } else {
                    self.graph[y][x] = .crossRed
                    self.heartRemaining -= 1
                    guess(is: .wrong)
                }
            } else if markerType == .cross {
                if board[y][x] == 0 {
                    self.graph[y][x] = .cross
                    guess(is: .correct)
                } else {
                    self.graph[y][x] = .boxRed
                    self.heartRemaining -= 1
                    guess(is: .wrong)
                }
            } else if markerType == .clue {
                if totalClue <= 0 {
                    guess(is: .wrong)
                } else {
                    totalClue -= 1
                    self.graph[y][x] = board[y][x] == 0 ? .cross : .black
                    guess(is: .correct)
                }
            }
        }
        
        wipeLine(point: point)
    }
    
    func wipeLine(point: CGPoint) {
        let x = Int(point.x) - 1
        let y = Int(point.y) - 1
        
        let completeRows = board[y].tally(valueToTally: 1)
        let completeCols = board.map{ $0[x] }.tally(valueToTally: 1)
        
        let revealedRows = graph[y].tally(valueToTally: .black)
        let revealedCols = graph.map{ $0[x] }.tally(valueToTally: .black)
        
        if completeRows == revealedRows {
            for index in 0..<boardSize {
                if graph[y][index] == .none {
                    self.graph[y][index] = .cross
                }
            }
        }
        
        if completeCols == revealedCols {
            for index in 0..<boardSize {
                if graph[index][x] == .none {
                    self.graph[index][x] = .cross
                }
            }
        }
    }
    
    func guess(is guess: Guesses) {
        switch guess {
        case .correct:
            myHaptic(engine: haptic, style: .common)
        case .wrong:
            self.pause = true
            myHaptic(engine: haptic, style: .wrong)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.pause = false
            })
        }
    }
    
    enum Guesses {
        case correct, wrong
    }
    enum MarkerType {
        case black, cross, clue
    }

}

extension PlayingViewModel {
    // ??? HOW ABOUT LOAD
    //MAYBE MAKE SAVE/LOAD Helper
    func autoSave(from: MyGamePart) {
        
    }
    
    enum MyGamePart {
        case main, challenge, event
    }
}
