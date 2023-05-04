//
//  Testing.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/3/23.
//

import SwiftUI

struct Testing: View {
    @State private var sample: DataStore = DS()
    @State private var scale: Double = 0.1
    
    let o: [CGSize] = {
        (0...1000)
            .map { _ in
                CGSize(width: .random(in: -50...50), height: .random(in: -100...100))
            }
    }()
    
    let hue: [Double] = {
        (0...1000)
            .map { _ in
                Double.random(in: 0.0 ... 1.0)
            }
    }()
    
    let randScale: [Double] = {
        (0...1000)
            .map { _ in
                Double.random(in: 0.1 ... 3.0)
            }
    }()
    
    
    var body: some View {
        VStack {
            //Text("\(inval)")
            ZStack {
                ForEach(0..<1000) { n in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(hue: hue[n], saturation: 0.5, brightness: 1))
                        .frame(width: 12, height: 12)
                        //.offset(x: CGFloat.random(in: -50...50), y: CGFloat.random(in: -100...100))
                        .offset(o[n])
                        .scaleEffect(randScale[n] + scale)
                }
            }
            Text("Hello")
                .onAppear{
                    //sample = DS()
                    //print(sample.getList())
                    //withAnimation (.easeInOut(duration: 1).repeatForever() ){
                      //  scale = 1.0
                    //}
                }
            Slider(value: $scale, in: 0.1 ... 1.0)
        }
    }
}

struct DS: DataStore {
    func getList() -> String {
        "World!"
    }
}
