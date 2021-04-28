////
////  ItalianRadio.swift
////  Tufoli
////
////  Created by Layne Johnson on 4/21/21.
////
//
//import Foundation
//
//// MARK: - Italian Radio
//
//class ItalianRadio {
//
//    let italianRadioSongs = ["Lucio Dalla - Washington.mp3", "Mango - Bella d'Estate.mp3", "Franco Battiato - Summer On A Solitary Beach.mp3" ]
//
//    var song = ""
//
//    var isPlaying = false
//
//    func chooseSong() -> String {
//        song = italianRadioSongs.randomElement()!
//        return song
//    }
//
//    func setSongLabel(song: String) {
//        // Modify song name string for display
//        let modifiedSong = song.replacingOccurrences(of: ".mp3", with: "", options: [.caseInsensitive, .regularExpression])
//        // Set song label
//        songLabel.text = modifiedSong
//    }
//
//}
//
