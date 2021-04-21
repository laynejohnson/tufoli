//
//  ViewController.swift
//  Tufoli
//
//  Created by Layne Johnson on 4/5/21.
//

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

    
    @IBAction func radioOnOff(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
        let italianRadioSongs = ["Lucio Dalla - Washington.mp3", "Mango - Bella d'Estate.mp3", "Franco Battiato - Summer On A Solitary Beach.mp3" ]
        let song = italianRadioSongs[0]
        
        // Remove .mp3 for display and display song
        let modifiedSong = song.replacingOccurrences(of: ".mp3", with: "", options: [.caseInsensitive, .regularExpression])
        songLabel.text = modifiedSong
     
        if sender.isSelected == true {
            playSound(song)
        } else if sender.isSelected == false {
            audioPlayer?.stop()
        }
    }
    
    
   
    let model = CardModel()
    var cardsArray = [Card]()
    
    // Initial View

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardsArray = model.getCards()
        
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

