//
//  TallyTextView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/1/23.
//

import SwiftUI

struct TallyTextView: View {
    let tallies: [Int]
    
    init(_ tallies: [Int]) {
        self.tallies = tallies
    }
    
    var body: some View {
        ForEach(0..<tallies.count, id: \.self) { n in
            Text("\(tallies[n])")
                .lineLimit(1)
                .minimumScaleFactor(0.05)
        }
        //.font(.custom("", size: self.fontSize(tallies.count)))
    }
    
    func fontSize(_ count: Int) -> Double {
        switch(count) {
        case 8:
            return 8.0
        case 7:
            return 9.0
        case 6:
            return 10.0
        case 5:
            return 12.0
        case 4:
            return 14.0
        default:
            return 16.0
        }
    }
}

struct TallyTextView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            TallyTextView([1,2,3])
        }
    }
}
