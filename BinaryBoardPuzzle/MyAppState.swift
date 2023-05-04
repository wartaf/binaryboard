//
//  Model.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 3/29/23.
//

import Foundation
import AVFoundation
import SwiftUI

class MyAppState: ObservableObject {
    
    @Published var currentScreen: MyCurrentScreen = .intro1
    @Published private var player: AVAudioPlayer?
    
    var resumeGameData: Bool? = true //FOR RESUMEGame, ResumeDataStructure
    
    /*
     
    [Main]
     NewGame (title, board = [[Int]] || UIImage)
     RestartGame (title, board[[Int]], exploredGraph[[NonoGridType]], heart, markerXO)
     
    Challenge
     Listing
      [Main]
     
    Collection
     Listing
      [Main]
     
    */
    
    init(currentScreen: MyCurrentScreen, player: AVAudioPlayer? = nil) {
        self.currentScreen = currentScreen
        self.player = player
    }
    
    init() {
        player = mySoundLoad(name: "fortress", type: "mp3")
    }
    
    func togglePlayMusic() {
        if let player = player {
            if player.isPlaying {
                player.stop()
            } else {
                player.play()
            }
        }
    }
    
    func setNextLevel() {
        self.currentScreen = .playing
    }
    
    enum MyCurrentScreen {
        case intro1, intro2, main, playing, test
    }
}

struct ChallengesData {
    let title: String
    let bgcolor: Color
    let cover: Image
    let levels: [LevelItem]
}

struct LevelItem {
    let title: String
    let imageURLName: String
    let description: String? //For trivia purpose?
}
