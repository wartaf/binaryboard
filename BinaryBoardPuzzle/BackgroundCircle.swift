//
//  BGCircle.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/24/23.
//

import SwiftUI

struct BackgroundCircle: View {
    let bgColor: Color = .blue
    @State private var rotation = 0.0
    
    var body: some View {
        VStack (spacing: 0){
            ZStack{
                
                let color: Color = .white
                let radial: [Color] = [color.opacity(0.5), color.opacity(0.0)]
                let radialGradient = RadialGradient(colors: radial, center: .center, startRadius: 0, endRadius: 50)
                Color.white
                bgColor.myLinearGradient
                
                radialGradient
                    .scaleEffect(3.0)
                
                ZStack{
                    /*
                    ForEach(0..<2) {n in
                        Circle()
                            .fill(radialGradient)
                            .frame(width: 100, height: 100)
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(90))
                            .padding(.trailing, (50.0 * Double(n)) + 80.0)
                            .rotationEffect(.degrees(rotation))
                    }
                     */
                    let total = 16
                    let sizeRange: Range<CGFloat> = 0.02..<0.8
                    let axisRange = -240..<240
                    
                    ForEach(0..<total, id: \.self) { n in
                        Circle()
                            //.fill(.white.opacity(0.15))
                            //.frame(width: .random(in: 2..<60), height: .random(in: 2..<60))
                            .fill(radialGradient)
                            .frame(width: 100, height: 100)
                            .scaleEffect(.random(in: sizeRange))
                            .offset(.init(width: .random(in: axisRange), height: .random(in: axisRange)))
                            .rotationEffect(.degrees(rotation))
                        
                    }
                }
                
            }
            .ignoresSafeArea()
            .onAppear{
                withAnimation (.linear(duration: 64).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
        }
    }
}

struct BackgroundCircle_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCircle()
    }
}

extension Color {
    var myLinearGradient: LinearGradient {
        let linearColors: [Color] = [self.opacity(0.8), self.opacity(0.7), self.opacity(0.9)]
        return LinearGradient(colors: linearColors, startPoint: .top, endPoint: .bottom)
    }
}
