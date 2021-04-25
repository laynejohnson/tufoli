//
//  ViewController.swift
//  Tufoli
//
//  Created by Layne Johnson on 4/5/21.
//  Copyright © 2021. All rights reserved.

import UIKit
import AVFoundation

// Set the view contoller as the object that is supplying the data to the collection + handle user events in collection view

// The view controller should conform to both delegate and datasource protocols for the UI Collection View Element

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var songLabel: UILabel!
    
    @IBOutlet weak var radioButtonPrevious: UIButton!
    
    @IBOutlet weak var radioButtonPlayPause: UIButton!
    
    @IBOutlet weak var radioButtonNext: UIButton!
    
    let model = CardModel()
    
    var cardsArray = [Card]()
    
    // MARK: Italian Radio
    
    let italianRadioSongs = ["Lucio Dalla - Washington.mp3", "Mango - Bella d'Estate.mp3", "Franco Battiato - Summer On A Solitary Beach.mp3" ]
    
    var song = ""
    
    var isPlaying = false
    
    func chooseSong() -> String {
        song = italianRadioSongs.randomElement()!
        return song
    }
    
    func setSongLabel(song: String) {
        // Modify song name string for display
        let modifiedSong = song.replacingOccurrences(of: ".mp3", with: "", options: [.caseInsensitive, .regularExpression])
        // Set song label
        songLabel.text = modifiedSong
    }
    
    @IBAction func playPreviousSong(_ sender: UIButton) {
        
        // TODO: italianRadioSongs - 1
        // Get current song
        let songIndex = italianRadioSongs.firstIndex(of: "\(song)")
        print(songIndex!)
//        // Get song - 1
//        // Play song - 1
//        if isPlaying == true {
//            let nextSong = chooseSong()
//            playSound(nextSong)
//            setSongLabel(song: nextSong)
//        } else if isPlaying == false {
//           // add animation to radio icon/flash press play
//
//        }
    }
    
    @IBAction func radioOnOff(_ sender: UIButton) {
        
        sender.isSelected.toggle()

        if sender.isSelected == true {
//            song = italianRadioSongs[0]
            song = chooseSong()
            setSongLabel(song: song)
            isPlaying = true
            playSound(song)
        } else if sender.isSelected == false {
            setSongLabel(song: "Press play to vibe...")
            isPlaying = false
            audioPlayer?.pause()
        }
    }
    
    // Add while loop itlianRadioSongs.count
    // of index == 3 repeat
    @IBAction func playNextSong(_ sender: UIButton) {
        // Get index of current song
        let songIndex = italianRadioSongs.firstIndex(of: "\(song)")
        print("Song index: \(songIndex!)")
        // Get index of next song
        let nextSongIndex = songIndex! + 1
        print("Next song index: \(nextSongIndex)")
        
        
//        if isPlaying == true {

//            // Get song + 1

//            // Play song + 1
//            let nextSong = italianRadioSongs[nextSongIndex]
//            playSound(nextSong)
//            // Set song label
//            setSongLabel(song: nextSong)
//        }


//
//
//        if isPlaying == true {
//            let nextSong = chooseSong()
//            playSound(nextSong)
//            setSongLabel(song: nextSong)
//        } else if isPlaying == false {
//            // add animation to radio icon/flash press play
//
//         }
    }
    
    // MARK: Initial View

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
        
        // Set song label
        setSongLabel(song: "Press play to vibe...")
        
        // Set the view controller as the datasource and delegate of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
    
    }
    
    // MARK: - Audio Player
    
    var audioPlayer: AVAudioPlayer?
    
    func playSound(_ soundName: String) {
        let path = Bundle.main.path(forResource: soundName, ofType:nil)!
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
                } catch {
                    // error handling
            }
    }
    
    // MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Stub methods. Number of items to display in a section; method returns integer.
        
        // Return number of cards
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Index path parameter gives cell coordinates (section, row) to reference cell; target cell.
        
        // Method asks the datasource which cell to display for each cell (0-n).
        
        // Method returns an entire UICollectionViewCell.
        
        // Get a cell
        // Use reuse identifier given to prototype cell ("CardCell")
        // Pass in indexPath parameter
        // dequeueReusableCell returns the cell to us, either creating a new one or recycling cells
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card from the card array
        let card = cardsArray[indexPath.row]
        
        // TODO: Finish configuring cell
        cell.configureCell(card: card)
        
        // Return cell
        // Returned CardCell is of data type CardCollectionViewCell
        // Returned cell must be casted
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get a reference to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
    
        // Flip the card
        cell?.flipUp()
    }
}

