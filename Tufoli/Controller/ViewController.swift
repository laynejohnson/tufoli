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
    

    @IBOutlet weak var italianRadioSwitch: UISwitch!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
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
       
        // Audio Player
        playSound("Lucio Dalla - Washington.mp3")
     

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as CardCollectionViewCell
        
        // TODO: Finish configuring cell
        
        // Return cell
        // Returned CardCell is of data type CardCollectionViewCell
        // Returned cell must be casted
        return cell
    }


}

