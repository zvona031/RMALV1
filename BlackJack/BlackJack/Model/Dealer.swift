//
//  Dealer.swift
//  BlackJack
//
//  Created by Zvonimir Pavlović on 19/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import Foundation

protocol BlackJackDealerDelegate: class {
    func updateDealersCards(imageName: String)
    func turnDownSideCard(imageName: String)
}

class Dealer: BlackJackMember {
    
    weak var delegate: BlackJackDealerDelegate?
    var handCards: [Card] = []
    var aceValue = 11
    var result = 0
    
    init(delegate: BlackJackDealerDelegate) {
        self.delegate = delegate
    }
    
    func initialPull() {
        handCards.append(contentsOf: Deck.shared.initialCardsPull())
        handCards[0].faceCardDown()
    }
    
    func pullSingleCard() -> String{
        handCards.append(Deck.shared.pullSingleCard())
        return handCards.last!.imageName
    }
    
    func calculateResult() {
        var result = 0
        for card in handCards {
            card.faceCardUp()
            result += card.calculateCard(aceValue: aceValue)
        }
        if result <= 16 {
            let imageName = pullSingleCard()
            delegate?.updateDealersCards(imageName: imageName)
            calculateResult()
        }
        else if result > 21 && aceValue == 11{
            aceValue = 1
            calculateResult()
        }
        else {
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
    
    func handleFaceDownCard(){
        let firstCard = handCards[0]
        firstCard.faceCardUp()
        delegate?.turnDownSideCard(imageName: firstCard.imageName)
    }
    
    func getResult() -> Int {
        handleFaceDownCard()
        calculateResult()
        return result
    }
    
    func reset(){
        handCards.removeAll()
        aceValue = 1
        result = 0
    }
}
