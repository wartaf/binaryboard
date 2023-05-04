//
//  AudioHelper.swift
//  BinaryBoardPuzzle
//
//  Created by Harry Pantaleon on 4/1/23.
//

import Foundation
import AVFoundation

func mySoundLoad(name: String, type: String?) -> AVAudioPlayer? {
    var player: AVAudioPlayer?
    if let bg = Bundle.main.path(forResource: "fortress", ofType: type) { //NSDataAsset(name: "bg"){
        do{
            let url = URL(string: bg)!
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: "mp3")
        } catch let error as NSError {
            print("Error: ", error.localizedDescription)
        }
    }
    
    return player
}

func mySoundBypassSilentMode() {
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback)
    } catch let error {
        print("ERROR AVSESSION: ", error.localizedDescription)
    }
}
