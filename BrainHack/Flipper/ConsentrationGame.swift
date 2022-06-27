//
//  ConsentrationGame.swift
//  BrainHack
//
//  Created by Uladzimir on 29.05.2022.
//

import Foundation

class ConsentrationGame{

    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCards: Int?
    var i = 0
    
    func chooseCard(at index: Int) -> Int{
        if !cards[index].isMatched{
            if let matchingIndex = indexOfOneAndOnlyFaceUpCards, matchingIndex != index{
                if cards[matchingIndex].identifier == cards[index].identifier{
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                    i+=1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCards = nil
            }else{
                for flipDown in cards.indices{
                    cards[flipDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCards = index
            }
        }
        return i
    }
    
        
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
    
}
