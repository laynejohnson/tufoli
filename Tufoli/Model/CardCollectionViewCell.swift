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
    
        self.card = card
        
        // Set front image of card
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            flipUp(speed: 0)
        }
        else {
            flipDown(speed: 0, delay: 0)
        }
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }
        else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        // Flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft] , completion: nil)
        
        // Set card state
        card?.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay:TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            // Flip down animation
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft] , completion: nil)
        }
        
        // Set card state
        card?.isFlipped = false
    }
    
    func remove() {
        
        // Make the image views invisible
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
    }
}
