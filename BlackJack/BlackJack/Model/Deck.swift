//
//  Deck.swift
//  BlackJack
//
//  Created by Zvonimir Pavlović on 19/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import Foundation

class Deck {
    
    static let shared = Deck()
    
    var deck: [Card] = []
    
    init() {
        createDeck()
    }
    
    func createDeck(){
        Rank.allCases.forEach{ rank in
            Suit.allCases.forEach { suit in
                self.deck.append(Card(rank: rank, suit: suit))
            }
        }
        deck.shuffle()
    }
    
    func resetDeck(){
        deck.removeAll()
        self.createDeck()
    }
    
    func pullSingleCard() -> Card{
        return self.deck.removeLast()
    }
    
    func initialCardsPull() -> [Card]{
        var initialCards: [Card] = []
        initialCards.append(self.deck.removeLast())
        initialCards.append(self.deck.removeLast())
        return initialCards
    }
    
}
