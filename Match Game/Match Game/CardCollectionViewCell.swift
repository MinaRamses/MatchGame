 //
//  CardCollectionViewCell.swift
//  Match Game
//
//  Created by Mina Ramses on 4/20/20.
//  Copyright © 2020 Mina Ramses. All rights reserved.
//

import UIKit
 import AVFoundation

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
 
    var card:Card?
    
    func setCard(_ card:Card){
     
        //Keep track of the card that gets passed in
        self.card = card
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            //using return statement to neglect the other line of codes in the method --> like "break" in a loop
            return
        }
        else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
         
        frontImageView.image = UIImage (named: card.imageName)
        // MARK: - Always gives ERROR!!
        //Determine if the card is in a flipped up state or flipped down state
        if card.isFlipped == true{
            //make sure the frontimage is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
        }
        else{
            //El 3aks
            
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func Flip(){
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
   
        
    }
    
    func remove(){
        //remove 2 cards from the grid
                // backImageView.alpha = 0
            //Animate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
        
        
        
    }
  }
