//
//  File.swift
//  BlackJack
//
//  Created by Zvonimir Pavlović on 19/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import Foundation

class Card {
    var rank: Rank
    var suit: Suit
    var imageName: String
    
    init(rank: Rank, suit:Suit) {
        self.rank = rank
        self.suit = suit
        self.imageName = self.rank.rawValue + self.suit.rawValue
    }
    
    func faceCardDown(){
        self.imageName = "green_back"
    }
    
    func faceCardUp(){
        self.imageName = self.rank.rawValue + self.suit.rawValue
    }
    
    func calculateCard(aceValue: Int) -> Int{
        switch self.rank {
        case .Two: return 2
        case .Three: return 3
        case .Four: return 4
        case .Five: return 5
        case .Six: return 6
        case .Seven: return 7
        case .Eight: return 8
        case .Nine: return 9
        case .Ten: return 10
        case .Jack: return 10
        case .Queen: return 10
        case .King: return 10
        case .Ace: return aceValue
        }
    }
}

enum Rank : String,CaseIterable{
    case Two = "2"
    case Three = "3"
    case Four = "4"
    case Five = "5"
    case Six = "6"
    case Seven = "7"
    case Eight = "8"
    case Nine = "9"
    case Ten = "10"
    case Ace = "A"
    case Jack = "J"
    case Queen = "Q"
    case King = "K"
    
}

enum Suit: String,CaseIterable {
    case Spades = "S"
    case Hearts = "H"
    case Diamonds = "D"
    case Clubs = "C"
}
