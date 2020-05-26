//
//  SoundManager.swift
//  Match Game
//
//  Created by Mina Ramses on 4/20/20.
//  Copyright © 2020 Mina Ramses. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum soundEffect {
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    static func playSound(_ effect:soundEffect){
        var soundFilename = ""
        
        switch effect {
        case .flip:
            soundFilename = "cardflip"
        case .shuffle:
            soundFilename = "shuffle"
        case .match:
            soundFilename = "dingcorrect"
        case .nomatch:
            soundFilename = "dingwrong"
            
        }
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        guard bundlePath != nil else{
            print("Couldn't play sound file \(soundFilename) in the bundle")
            return
        }
        //create URL
        let soundURL = URL(fileURLWithPath: bundlePath!)
        do{
            //create audio player
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            audioPlayer?.play()
            
        }catch{
            print("Couldn't create the audio player object for sound file \(soundFilename)")
            
        }
        
        
    }
}
