//
//  ChallengeView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/25/23.
//

import SwiftUI

struct ChallengeView: View {
    @EnvironmentObject var myAppState: MyAppState
    
    var body: some View {
        VStack{
            BackgroundCircle()
            Rectangle()
            VStack{
                Button("StartSound"){
                    myAppState.togglePlayMusic()
                }
                
                Button("Press") {
                    myAppState.currentScreen = .intro1
                }
                
            }
        }

    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
