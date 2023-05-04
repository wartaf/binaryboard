//
//  MainView.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/25/23.
//

import SwiftUI

struct MainView: View {
    //var callBack: (() -> Void)? = nil
    @State private var tabSelected: TabMenu = .main
    enum TabMenu {
        case main, challenge, collection
    }
    var body: some View {
        TabView(selection: $tabSelected){
            /*
            Test2()
                .tabItem {
                    Label("Test", systemImage: "rectangle")
                }
            */
            MainMenuView()
                .tabItem({
                    Label("Main", systemImage: "house")
                })
                .tag(TabMenu.main)
            ChallengeView()
                .tabItem({
                    Label("Challenge", systemImage: "flag.checkered.2.crossed")
                })
                .tag(TabMenu.challenge)
            
            //PlayingView(imageName: "template", size: 20)
            //PlayingView(boardArray: uiImageToBoardYCBCR(image: UIImage(named: "hary")!))
            
            Testing()
                .tabItem({
                    Label("Collection", systemImage: "text.line.last.and.arrowtriangle.forward")
                })
                .tag(TabMenu.collection)
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
