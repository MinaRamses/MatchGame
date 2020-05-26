 //
 //  CardModel.swift
 //  Match Game
 //
 //  Created by Mina Ramses on 4/20/20.
 //  Copyright © 2020 Mina Ramses. All rights reserved.
 //
 
 import Foundation
 import AVFoundation
 
 class CardModel {
    
    func getCards() ->[Card ] {
        
        var generateNumbersArray = [Int]()
        
        //Declare an array to store the generated card
        var generatedCardsArray = [Card]()
        
        
        
        //Randomly generate pairs of cards
        while generateNumbersArray.count < 8 {
            
            let randomNumber = arc4random_uniform(13)+1
            
            if generateNumbersArray.contains(Int(randomNumber)) == false{
                
                print(randomNumber)
                
                generateNumbersArray.append(Int(randomNumber) )
                // Create first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardOne)
                
                //Create second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
                
            }
            
            
        }
        
        
        
        //TODO: Randomize the array
        for i in 0...generatedCardsArray.count-1{
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            let tmp = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = tmp
            
        }
        //return the array
        
        return generatedCardsArray
        
        
    }
 }
