//
//  ViewController.swift
//  Tufoli
//
//  Created by Layne Johnson on 4/5/21.
//  Copyright © 2021. All rights reserved.

import UIKit
import AVFoundation

// TODO: Change alert to pop-up & add reset game
// TODO: Add intro/music screen

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    // MARK: - Initial View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isHidden = true
        
        cardsArray = model.getCards()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Audio Player
    
    var audioPlayer: AVAudioPlayer?
    
    func playSound(_ soundName: String) {
        
        let path = Bundle.main.path(forResource: soundName, ofType:nil)!
        
        let url = URL(fileURLWithPath: path)
        
        do {
            // Create the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            // Play the sound effect
            audioPlayer?.play()
            
        } catch {
            
            print("Could not summon audio player")
        }
    }
    
    // MARK: - Italian Radio
    
    let italianRadioSongs = ["Lucio Dalla - Washington.mp3", "Mango - Bella d'Estate.mp3", "Franco Battiato - Summer On A Solitary Beach.mp3" ]
    
    var song = ""
    
    var isPlaying = false
    
    func chooseSong() -> String {
        
        song = italianRadioSongs.randomElement()!
        return song
    }
    
    @IBAction func soundOnOff(_ sender: UIButton) {
        
        // Toggle radio state
        sender.isSelected.toggle()
        
        if sender.isSelected == true {
            
            isPlaying = true
            song = italianRadioSongs[0]
            //           setSongLabel(song: song)
            playSound(song)
            
        } else if sender.isSelected == false {
            
            isPlaying = false
            audioPlayer?.pause()
            // setSongLabel(song: defaultSongLabel)
        }
    }
    
    // MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Number of items to display in a section
        
        // Return number of cards
        return cardsArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // This method is called when the collection view wants to use a cell/create a cell for a particular index
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Return cell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // This method is called right before a cell gets displayed
        
        // Configure the state of the cell based on card properties
        let cardCell = cell as? CardCollectionViewCell
        
        // Get the card from the card array
        let card = cardsArray[indexPath.row]
        
        cardCell?.configureCell(card: card)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get a reference to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check the status of a card to determine flip direction
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
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
            
            // Check if pair was last pair
            checkForGameEnd()
            
        } else {
            
            // Set card status
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip them back over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
    
    func checkForGameEnd() {
        
        // Check for unmatched cards
        
        // Assume the player has won, loop through all the cards to see if all are matched
        var hasWon = true
        
        for card in cardsArray {
            if card.isMatched == false {
                hasWon = false
                break
            }
        }
        
        if hasWon == true {
            // TODO: Setup pop-up
            // performSegue(withIdentifier: "PlayAgain", sender: self)
            
            // Show alert
            showAlert(title: "Congratulazioni! Sei una vera Pastaia!", message: "Nonni è orgogliosa 🤩")
        }
    }
    
    func resetGame() {
        
        cardsArray = model.getCards()
        
        // Reset first flipped card index
        firstFlippedCardIndex = nil
        
        // Reload collection view
        collectionView.reloadData()
    }
    
    func showAlert(title:String, message:String) {
        
        // Create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Alert action
        let playAgainAction = UIAlertAction(title: "Play Again", style: .default) { [self] playAgainAction in
            
            // Perform UI update in main thread
            DispatchQueue.main.async {
                self.resetGame()
            }
        }
        
        alert.addAction(playAgainAction)
        
        // Show the alert
        present(alert, animated: true, completion: nil)
    }
    
    // Swipe to reset game
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        
        print("Game has been reset")
        
        // Reset game
        resetGame()
    }
}
