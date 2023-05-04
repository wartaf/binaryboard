//
//  Test2.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 4/26/23.
//

import SwiftUI

struct Test2: View {
    
    @State private var effect = 0.0
    @State private var slide = 0.0

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .onTapGesture {
                    print("rectangle")
                }
            VStack {
                Spacer()
                VStack {
                    Text("Hello")
                    Button("TestBtn") {
                        print("testing")
                    }
                }
                .background(.green)
            }
            
        }
    }
}



struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}

