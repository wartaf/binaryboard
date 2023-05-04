//
//  ContentView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 1/11/23.
//

import SwiftUI
import AVFoundation



struct ContentView: View {
    
    @StateObject var myAppState = MyAppState()
    
    private var intro1Time: Double { 2 }
    private var intro2Time: Double { 2.1 }
    
    @State private var intro1Opacity: Double = 0
    @State private var intro2Opacity: Double = 0
    
    var body: some View {
        ZStack{
            if myAppState.currentScreen == .test {
                
                //Testing()
            } else if myAppState.currentScreen == .intro1 {
                Intro1View()
                    .opacity(intro1Opacity)
                    .onAppear{
                        intro1Opacity = 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + intro1Time, execute: {
                            withAnimation (.easeOut(duration: 1)){
                                intro1Opacity = 0
                                myAppState.currentScreen = .intro2
                            }
                        })
                    }
            } else if myAppState.currentScreen == .intro2 {
                Intro2View()
                    .opacity(intro2Opacity)
                    .onAppear{
                        intro2Opacity = 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + intro2Time, execute: {
                            withAnimation {
                                intro2Opacity = 0
                                myAppState.currentScreen = .main
                            }
                        })
                    }
            } else {
                //if myAppState.currentScreen == .main {
                    MainView()
                //} else
                if myAppState.currentScreen == .playing {
                    ZStack {
                        Color.white.ignoresSafeArea()
                        VStack{
                            PlayingView()
                        }
                    }
                }
            }
        }
        .onAppear{
            //print(sum(5))
            //print(goCorner(n: 2, m: 2))
            //print(goCorner(n: 6, m: 6))
            
        }
        .environmentObject(myAppState)
    }
    
    func sum(_ n: Int) -> Int {
        if n > 0 { return sum (n - 1) + n }
        return n
    }
    
    func goCorner(n:Int, m:Int) -> Int {
        print(n,m)
        if n > 1 || m > 1 {
            if n >= m {
                return goCorner(n: n - 1, m: m) + 1
            } else {
                return goCorner(n: n, m: m - 1) + 1
            }
        } else {
            return 0
        }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
