//
//  CardCollectionViewCell.swift
//  Tufoli
//
//  Created by Layne Johnson on 4/14/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    // Custom subclass cell CardCollectionViewCell contains IBOutlets for front and back image views
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func configureCell(card: Card) {
        
        // Keep track of the card that this cell represents
        self.card = card
        
        // Set the front image view to the image that represents the card
        frontImageView.image = UIImage(named: card.imageName)
        
        // Reset the state of the cell by checking the flip state of the card
        if card.isFlipped == true {
            // Show front image view
            flipUp(speed: 0)
        } else {
            // Show back image view
            
        }
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        // Flip up animation
        // Completion is code that runs after transition
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.showHideTransitionViews, .transitionFlipFromLeft] , completion: nil)
    }
    
    func flipDown(speed: TimeInterval = 0.3) {
        // Flip down animation
        UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.showHideTransitionViews, .transitionFlipFromLeft] , completion: nil)
        
    }
}
