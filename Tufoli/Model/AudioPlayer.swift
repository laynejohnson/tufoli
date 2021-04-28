////
////  AudioPlayer.swift
////  Tufoli
////
////  Created by Layne Johnson on 4/26/21.
////
//
//import Foundation
//import AVFoundation
//
//class AudioPlayer {
//
//var audioPlayer: AVAudioPlayer?
//
//func playSound(_ soundName: String) {
//    let path = Bundle.main.path(forResource: soundName, ofType:nil)!
//
//    let url = URL(fileURLWithPath: path)
//
//    do {
//        audioPlayer = try AVAudioPlayer(contentsOf: url)
//        audioPlayer?.play()
//    } catch {
//        // error handling
//    }
//}
//
//}
