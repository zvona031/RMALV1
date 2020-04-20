//
//  YambViewViewModel.swift
//  Yamb
//
//  Created by Zvonimir Pavlović on 17/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import Foundation

class YambViewViewModel {
    
    var dices : [Dice] = [Dice(),Dice(),Dice(),Dice(),Dice(),Dice()]
    weak var delegate: YambViewModelDelegate?
    var rolled = 0
    var result: String = "No result"
    
    func singleDiceRoll(dice: Dice){
        let tempValue = Int.random(in: 1 ... 6)
        dice.value = tempValue
    }
    
    func diceClicked(dice: Dice){
        if(rolled != 0){
            if(dice.locked == true){
                dice.locked = false
                print("Dice unlocked")
            }else{
                dice.locked = true
                print("Dice locked.")
            }
            delegate?.updateDiceImages()
        }
    }
    
    func rollClicked(){
        for dice in dices {
            if(dice.locked == false){
                singleDiceRoll(dice: dice)
            }
        }
        checkGameStatus()
    }
    
    func checkGameStatus(){
        if(rolled >= 2){
            checkResult()
            restartGame()
            print("Game restarted")
        }else{
            rolled+=1
            delegate?.updateDiceImages()
        }
    }
    
    func restartGame(){
        for dice in dices {
            dice.locked = false
        }
        rolled = 0
        delegate?.updateDiceImages()
        result = "No result"
    }
    
    func checkResult(){
        var results : [Int] = []
        for dice in dices {
            guard let tempResult = dice.value else {return}
            results.append(tempResult)
        }
        print(results)
        checkForYamb(results: results)
        checkForScale(results: results)
    }
    
    func checkForYamb(results: [Int]){
        
        for result in results {
            var counter = 0
            for otherResult in results {
                if(result == otherResult){
                    counter+=1
                }
            }
            print(counter)
            if(counter == 4){
                self.result = "Poker!"
                return
            }else if(counter >= 5){
                self.result = "Yamb!"
                return
            }
        }
    }
    
    func checkForScale(results: [Int]){
        let orderedResults = results.sorted()
        var scale = 0
        var lastTempResult = orderedResults[0] - 1
        for currentResult in orderedResults {
            if (currentResult > lastTempResult && (currentResult - lastTempResult) == 1){
                scale+=1
                lastTempResult = currentResult
            }
        }
        if(scale >= 5){
            result = "Skala!"
        }
    }
}

protocol YambViewModelDelegate: class {
    func updateDiceImages()
}
