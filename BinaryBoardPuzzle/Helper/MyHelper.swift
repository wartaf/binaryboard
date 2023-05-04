//
//  MyHelper.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 4/8/23.
//

import Foundation


extension Array {
    mutating func PriorityQueuePush(i: Element) {
        self.insert(i, at: self.count)
    }
    mutating func PriorityQueuePop() -> Element {
        return self.remove(at: 0)
    }
}
