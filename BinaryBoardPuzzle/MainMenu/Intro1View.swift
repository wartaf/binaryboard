//
//  Intro1View.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/13/23.
//

import SwiftUI

struct Intro1View: View {
    @State private var scaleAnimation: Double = 0.2
    
    var body: some View {
        Text("iAmHPP")
            .font(.custom("Helvetica", size: 28))
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .foregroundColor(.black.opacity(0.8))
            .scaleEffect(scaleAnimation)
            .onAppear{
                withAnimation (.interpolatingSpring(stiffness: 100, damping: 4)){
                    scaleAnimation = 1
                }
            }
    }
}

struct Intro1View_Previews: PreviewProvider {
    static var previews: some View {
        Intro1View()
    }
}
