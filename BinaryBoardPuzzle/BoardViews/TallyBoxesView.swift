//
//  TallyBoxesView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/1/23.
//

import SwiftUI

struct VTallyBoxesView: View {
    let board: [[Int]]
    
    init(_ board: [[Int]]) {
        self.board = board
    }
    
    var body: some View {
        ForEach(0..<board.count, id: \.self) { cols in
            RoundedRectangle(cornerRadius: 4)
                .fill(.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    HStack (spacing: 2){
                        TallyTextView(board[cols].tally(valueToTally: 1))
                    }
                )
        }
    }
    
    enum Orientation {
        case horizontal, vertical
    }
}

struct HTallyBoxesView: View {
    let board: [[Int]]
    
    init(_ board: [[Int]]) {
        self.board = board
    }
    
    var body: some View {
        ForEach(0..<board.count, id: \.self) { rows in
            RoundedRectangle(cornerRadius: 4)
                .fill(.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    VStack (spacing: 2){
                        TallyTextView(board.map{ $0[rows] }.tally(valueToTally: 1))
                        //Text(" ")
                    }
                        .padding(2)
                )
        }
    }
}

struct VTallyBoxesView_Previews: PreviewProvider {
    
    static var previews: some View {
        let board: [[Int]] = [
            [1,0,1,0,1],
            [1,0,0,0,1],
            [1,1,1,1,1],
            [1,0,0,0,1],
            [0,1,0,1,1],
        ]
        HStack (spacing: 2){
            VTallyBoxesView(board)
        }
    }
}

