//
//  Intro2View.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/13/23.
//

import SwiftUI

struct Intro2View: View {
    @State private var scaleText: Double = 1.8
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.15)
            RoundedRectangle(cornerRadius: 48)
                .fill(.white)
                .rotationEffect(.degrees(30))
                .frame(width: 500, height: 500, alignment: .leading)
                .offset(.init(width: 80, height: 48))
            Text("NonoGram")
                .scaleEffect(scaleText)
                .onAppear{
                    withAnimation (.easeOut(duration: 1.4)) {
                        scaleText = 1
                    }
                }
        }
        .ignoresSafeArea()
    }
}

struct Intro2View_Previews: PreviewProvider {
    static var previews: some View {
        Intro2View()
    }
}
