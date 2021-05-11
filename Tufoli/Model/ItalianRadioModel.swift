////
////  ItalianRadioModel.swift
////  Tufoli
////
////  Created by Layne Johnson on 5/11/21.
////
//
//import Foundation
//import AVFoundation
//import UIKit
//
//class ItalianRadioModel {
//    
//    @IBOutlet weak var songLabel: UILabel!
//
//    @IBOutlet weak var radioButtonPrevious: UIButton!
//    
//    @IBOutlet weak var radioButtonPlayPause: UIButton!
//    
//    @IBOutlet weak var radioButtonNext: UIButton!
//    
//    let defaultSongLabel = "Press play to vibe ✨ 🍝 🤙"
//    let italianDefaultSongLabel = "Premere play per vibe ✨ 🍝 🤙"
//    
//    // MARK: Audio Player
//    
//    var audioPlayer: AVAudioPlayer?
//    
//    func playSound(_ soundName: String) {
//        
//        let path = Bundle.main.path(forResource: soundName, ofType:nil)!
//        
//        let url = URL(fileURLWithPath: path)
//        
//        do {
//            // Create the audio player
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            // Play the sound effect
//            audioPlayer?.play()
//        } catch {
//            print("Could not summon audio player")
//        }
//    }
//    
//    // MARK: - Italian Radio
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
//    
//    @IBAction func playPreviousSong(_ sender: UIButton) {
//        if isPlaying == true {
//            
//            // Get index of current song
//            print("Current song: \(song)")
//            let songIndex = italianRadioSongs.firstIndex(of: "\(song)")
//            print("Song index: \(songIndex!)")
//            
//            // Get index of previous song
//            var previousSongIndex = songIndex! - 1
//            print("previous song index: \(previousSongIndex)")
//            
//            // Reset index at end of array
//            if previousSongIndex > italianRadioSongs.count - 1 || previousSongIndex < 0 {
//                
//                previousSongIndex = italianRadioSongs.endIndex - 1
//                let previousSong = italianRadioSongs[previousSongIndex]
//                song = previousSong
//                playSound(song)
//                setSongLabel(song: song)
//            } else {
//                
//                // Play previous song
//                let previousSong = italianRadioSongs[previousSongIndex]
//                print("previous song: \(previousSong)")
//                song = previousSong
//                print("New Current Song: \(song)")
//                playSound(song)
//                
//                // Set song label for next song
//                // TODO: Refactor; add setSongLabel label function to playSound function
//                setSongLabel(song: previousSong)
//            }
//        } else {
//            
//            // Add animation to "Press play to vibe"
//            print(defaultSongLabel)
//        }
//    }
//    
//    @IBAction func radioOnOff(_ sender: UIButton) {
//        // Toggle radio state
//        sender.isSelected.toggle()
//        
//        if sender.isSelected == true {
//            isPlaying = true
//            song = italianRadioSongs[0]
//            setSongLabel(song: song)
//            playSound(song)
//        } else if sender.isSelected == false {
//            isPlaying = false
//            audioPlayer?.pause()
//            setSongLabel(song: defaultSongLabel)
//        }
//    }
//    
//    
//    @IBAction func playNextSong(_ sender: UIButton) {
//        if isPlaying == true {
//            // Get index of current song
//            print("Current song: \(song)")
//            let songIndex = italianRadioSongs.firstIndex(of: "\(song)")
//            print("Song index: \(songIndex!)")
//            
//            // Get index of next song
//            var nextSongIndex = songIndex! + 1
//            print("Next song index: \(nextSongIndex)")
//            
//            // Reset index at end of array
//            if nextSongIndex > italianRadioSongs.count - 1 {
//                nextSongIndex = 0
//                let nextSong = italianRadioSongs[nextSongIndex]
//                song = nextSong
//                playSound(song)
//                setSongLabel(song: song)
//            } else {
//                // Play next song
//                let nextSong = italianRadioSongs[nextSongIndex]
//                print("Next song: \(nextSong)")
//                song = nextSong
//                print("New Current Song: \(song)")
//                playSound(song)
//                
//                // Set song label for next song
//                // TODO: Refactor; add setSongLabel label function to playSound function
//                setSongLabel(song: nextSong)
//            }
//        } else {
//            // Add animation to "Press play to vibe"
//            print(defaultSongLabel)
//        }
//    } // End playNextSong
//} // End ItalianRadioModel Class
