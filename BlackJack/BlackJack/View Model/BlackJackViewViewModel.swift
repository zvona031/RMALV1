//
//  BlackJackViewViewModel.swift
//  BlackJack
//
//  Created by Zvonimir Pavlović on 19/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import Foundation

protocol BlackJackViewDelegate: class{
    func onGameStarted(playerCards: [String],dealerCards: [String])
    func cardsUpdate(imageName: String, stackID: Int)
    func turnDealersCardUpsideDown(imageName: String)
    func updateFinalResults(playerResult: Int, dealerResult: Int,message: String)
    func updatePlayerResult(playerResult: Int)
    func playerLoses(playerResult: Int,message: String)
}

class BlackJackViewViewModel: BlackJackDealerDelegate {

    var deck : Deck = Deck()
    var player : BlackJackMember = Player()
    lazy var dealer : BlackJackMember = Dealer(delegate: self)
    weak var delegate : BlackJackViewDelegate?
    
    init(delegate: BlackJackViewDelegate) {
        self.delegate = delegate
    }
    
    func startGame(){
        player.initialPull()
        dealer.initialPull()
        delegate?.onGameStarted(playerCards: player.returnInitialCardNames(), dealerCards: dealer.returnInitialCardNames())
        updateResult()
    }
    
    func hitClicked(){
        let imageName = player.pullSingleCard()
        updateResult()
        delegate?.cardsUpdate(imageName: imageName,stackID: 1)
    }
    
    func updateResult(){
        let currentResult = player.getResult()
        delegate?.updatePlayerResult(playerResult: currentResult)
        if( currentResult > 21){
            player.reset()
            dealer.reset()
            Deck.shared.resetDeck()
            delegate?.playerLoses(playerResult: currentResult, message: "Dealer wins!")
        }
    }
    
    func updateDealersCards(imageName: String) {
        delegate?.cardsUpdate(imageName: imageName, stackID: 2)
    }
    
    func turnDownSideCard(imageName: String) {
        delegate?.turnDealersCardUpsideDown(imageName: imageName)
       }
    
    func standClicked(){
        let playerResult: Int = player.getResult()
        let dealerResult: Int = dealer.getResult()
        var message = "Result"
        if(playerResult > 21){
            message = "Dealer wins!"
        }else if(dealerResult > 21){
            message = "Player wins!"
        }else if(playerResult > dealerResult){
            message = "Player wins!"
        }else if(playerResult == dealerResult){
            message = "Draw!"
        }else {
            message = "Dealer wins!"
        }
        player.reset()
        dealer.reset()
        Deck.shared.resetDeck()
        delegate?.updateFinalResults(playerResult: playerResult, dealerResult: dealerResult,message: message)
    }
}
