//
//  CardCollectionViewCell.swift
//  Tufoli
//
//  Created by Layne Johnson on 4/14/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func configureCell(card: Card) {
        
        // Keep track of the card that this cell represents
        self.card = card
        
        // Set the front image view
        frontImageView.image = UIImage(named: card.imageName)
        
        // Check if card is matched
        if (card.isMatched) {
            
            // Set image alpha
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
            
        } else {
            
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        // Reset the state of the cell by checking flipped status
        if (card.isFlipped) {
            
            // Show card front
            flipUp(speed: 0);
            
        } else {
            
            // Show card back
            flipDown(speed: 0, delay: 0);
        }
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        // Flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        // Set card as flipped
        card?.isFlipped = true;
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay: TimeInterval = 0.5) {
        
        // Flip down animation
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
            
            // Set the status of the card
            self.card?.isFlipped = false;
        }
    }
    
    func remove() {
        
        // Make back image view invisible
        backImageView.alpha = 0
        
        // Make front image view invisible
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
    }
}
