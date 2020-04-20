//
//  Player.swift
//  BlackJack
//
//  Created by Zvonimir Pavlović on 19/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import Foundation

class Player: BlackJackMember {
    
    var handCards: [Card] = []
    var aceValue: Int = 11
    var result = 0
    
    func initialPull(){
        handCards.append(contentsOf: Deck.shared.initialCardsPull())
    }
    
    func pullSingleCard() -> String{
        handCards.append(Deck.shared.pullSingleCard())
        return handCards.last!.imageName
    }
    
    func calculateResult(){
        var result = 0
        for card in handCards {
            result += card.calculateCard(aceValue: aceValue)
        }
        if result > 21 && aceValue == 11 {
            aceValue = 1
            calculateResult()
        }else {
            self.result = result
        }
        
    }
    
    func returnInitialCardNames() -> [String]{
        var cardNames:[String] = []
        handCards.forEach { card in
            cardNames.append(card.imageName)
        }
        return cardNames
    }
    
    func getResult() -> Int {
        calculateResult()
        return result
    }
    
    func reset(){
        handCards.removeAll()
        aceValue = 1
        result = 0
    }

}
