//
//  NonoGraph.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/22/23.
//

import SwiftUI

struct NonoGraph: Shape {
    let size: Double
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let wn = rect.width / size
        
        //path.addRect(.init(x: 0, y: 0, width: 2, height: width))
        //path.addRect(.init(x: 0, y: 0, width: width, height: 2))
        //path.addRect(.init(x: 0, y: width - 1, width: width, height: 2))
        //path.addRect(.init(x: width - 1, y: 0, width: 2, height: width))
        
        var counter = 1
        for i in stride(from: wn, to: width, by: wn) {
            let lineWeight: Double = counter % 5 == 0 ? 2 : 1
            let axis = i //counter % 5 == 0 ? i - 1 : i
            path.addRect(.init(x: axis, y: 0, width: lineWeight, height: width))
            path.addRect(.init(x: 0, y: axis, width: width, height: lineWeight))
            counter += 1
        }
        
        return path
    }
    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        CGSize(width: proposal.width ?? 200, height: proposal.width ?? 200)
    }
}

struct NonoGraph_Previews: PreviewProvider {
    static var previews: some View {
        NonoGraph(size: 10)
    }
}
