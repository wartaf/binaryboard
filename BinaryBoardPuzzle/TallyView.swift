//
//  TallyView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 1/26/23.
//

import SwiftUI

struct TallyView: View {
    let tallyCounts: [Int]
    let tallyCoverCounts: [Int]?
    var body: some View {
        Group {
            ForEach(tallyCounts, id: \.self) { n in
                let isUncover = tallyCoverCounts?.contains(where: { e in
                    e == n
                }) ?? false
                
                Text("\(n)")
                    .foregroundColor(isUncover ? .secondary : .primary)
            }
        }
    }
}

struct TallyView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            TallyView(tallyCounts: [1,2,3,4,5], tallyCoverCounts: [1,4,5])
        }
    }
}
