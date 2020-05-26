//
//  ViewController.swift
//  Match Game
//
//  Created by Mina Ramses on 4/20/20.
//  Copyright © 2020 Mina Ramses. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var Copyrights: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 40 * 1000
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Create Timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerELapsed), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
       SoundManager.playSound(.shuffle)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Timer Methods
    
    @objc func timerELapsed(){
        
        
        timerLabel.textColor = UIColor.black
        milliseconds -= 1
        //convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        //set label
        timerLabel.text = "Time Remaining: \(seconds)"
        //stop the timer
        if milliseconds <= 0{
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            checkGameEnded()
        }
        
    }
    
    // MARK: - UICollectionView Protocol Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath ) as! CardCollectionViewCell
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //check if there is any time left
        if milliseconds <= 0{
            return
        }
        
        //get the cell from user
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //get the card from user
        let card = cardArray[indexPath.row]
        
        
        if card .isFlipped == false && card.isMatched == false{
            
            //flip the card
            
            cell.Flip()
            card.isFlipped = true
            
            //Play sound
            SoundManager.playSound(.flip)
            
            
            //Determine if it's the first card or the second card that's flipped over
            if firstFlippedCardIndex == nil{
                //This is the first card that have been flipped
                firstFlippedCardIndex  = indexPath
            }
            else{
                //This is the second card that have been flipped
                
                //Matching Card *LOGIC*
                checkForMatches(indexPath)
                
                
            }
        }
        
    }
    
    // MARK: - Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        //get the cell
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //get the card
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //compare the 2 cards
        
        if cardOne.imageName == cardTwo.imageName{
            
            //it's a match
            
            //play sound
            SoundManager.playSound(.match)
            
            //set the statuses of the card
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            
            //remove the cards from grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //check if there is any card left unmatched
            checkGameEnded()
            
        }
            
        else{
            //it's not a match
            
            //play sound
            SoundManager.playSound(.nomatch)
            
            //set the statuses of the card
            cardOne.isFlipped=false
            cardTwo.isFlipped=false
            
            //flip back the cards
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        firstFlippedCardIndex = nil
        
    }
    
    func checkGameEnded() {
        
        //Deretmine if there are any cards unmatched
        var isWon = true
        
        for card in cardArray{
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        //Message variables
        var title = ""
        var message = ""
        
        //if not, then user won, stop the timer
        if isWon == true{
            if milliseconds > 0{
                timer?.invalidate()
            }
            title = "Congratulations!!!"
            message = "You've WON ;)"
            
        }
        else{
            //if there are unmatched cards, check if there is any time left
            if milliseconds > 0{
                return
            }
            title = "Game Over...!"
            message = "You've LOST :("
            
        }
        //show won/lost message
        showAlert(title, message)
        
    }
    func showAlert(_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

