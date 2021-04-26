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
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var songLabel: UILabel!
    
    @IBOutlet weak var radioButtonPrevious: UIButton!
    
    @IBOutlet weak var radioButtonPlayPause: UIButton!
    
    @IBOutlet weak var radioButtonNext: UIButton!
    
    // MARK: - Variables
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    // Declare porperties to track flipped cards
    // If property is nil, no card has been selected
    var firstFlippedCardIndex: IndexPath?
    
    // MARK: - Italian Radio
    
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
        
        if isPlaying == true {
            
            // Get index of current song
            print("Current song: \(song)")
            let songIndex = italianRadioSongs.firstIndex(of: "\(song)")
            print("Song index: \(songIndex!)")
            
            // Get index of previous song
            var previousSongIndex = songIndex! - 1
            print("previous song index: \(previousSongIndex)")
            
            // Reset index at end of array
            if previousSongIndex > italianRadioSongs.count - 1 || previousSongIndex < 0 {
                previousSongIndex = italianRadioSongs.endIndex - 1
                let previousSong = italianRadioSongs[previousSongIndex]
                song = previousSong
                playSound(song)
                setSongLabel(song: song)
            } else {
                
                // Play previous song
                let previousSong = italianRadioSongs[previousSongIndex]
                print("previous song: \(previousSong)")
                song = previousSong
                print("New Current Song: \(song)")
                playSound(song)
                
                // Set song label for next song
                // TODO: Refactor; add setSongLabel label function to playSound function
                setSongLabel(song: previousSong)
            }
        } else {
            // Add animation to "Press play to vibe"
            print("Press play to vibe")
        }
    }
    
    @IBAction func radioOnOff(_ sender: UIButton) {
        
        // Toggle radio state
        sender.isSelected.toggle()
        
        if sender.isSelected == true {
            isPlaying = true
            song = italianRadioSongs[0]
            setSongLabel(song: song)
            playSound(song)
        } else if sender.isSelected == false {
            isPlaying = false
            audioPlayer?.pause()
            setSongLabel(song: "Press play to vibe...")
        }
    }
    
    @IBAction func playNextSong(_ sender: UIButton) {
        
        if isPlaying == true {
            // Get index of current song
            print("Current song: \(song)")
            let songIndex = italianRadioSongs.firstIndex(of: "\(song)")
            print("Song index: \(songIndex!)")
            
            // Get index of next song
            var nextSongIndex = songIndex! + 1
            print("Next song index: \(nextSongIndex)")
            
            // Reset index at end of array
            if nextSongIndex > italianRadioSongs.count - 1 {
                nextSongIndex = 0
                let nextSong = italianRadioSongs[nextSongIndex]
                song = nextSong
                playSound(song)
                setSongLabel(song: song)
            } else {
                // Play next song
                let nextSong = italianRadioSongs[nextSongIndex]
                print("Next song: \(nextSong)")
                song = nextSong
                print("New Current Song: \(song)")
                playSound(song)
                
                // Set song label for next song
                // TODO: Refactor; add setSongLabel label function to playSound function
                setSongLabel(song: nextSong)
            }
        } else {
            // Add animation to "Press play to vibe"
            print("Press play to vibe")
        }
    }
    
    // MARK: - Initial View
    
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
    // TODO: Refactor. Create AudioPlayer class
    
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
        // `as` keyword casts returned object as type CardCollectionViewCell
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
        
        // Check the status of a card to determine flip direction
        if cell?.card?.isFlipped == false {
            
            // Flip the card up
            cell?.flipUp()
            
            // Check if the card is the first or second flipped card
            
            if firstFlippedCardIndex == nil {
                
                // This is the first card
                firstFlippedCardIndex = indexPath
                
            }
            else {
                // This is the second card
                
                // Run comparison logic
                checkForMatch(indexPath)
            }
        }
    }
    
    // MARK: - Game Logic Methods
    
    // _ allows parameter label to be omitted from function call
    func checkForMatch(_ secondFlippedCardIndex: IndexPath) {
        
        // Get the card objects from the two indices and see if they match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        // Get the two collections view cells that represent card one and two
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Compare the cards
        if cardOne.imageName == cardTwo.imageName {
            
            // It's a match
            
            // Set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        } else {
            
            // It is not a match
            
            // Flip them back over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
}

