//
//  DiceCellCollectionViewCell.swift
//  Yamb
//
//  Created by Zvonimir Pavlović on 17/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import UIKit

class DiceCell: UICollectionViewCell {
    
    
    @IBOutlet weak var diceImage: UIImageView!
    
    var dice: Dice? {
        didSet{
            bindDice()
        }
    }
    
    func bindDice(){
        if(dice?.value == nil){
            diceImage.image = UIImage(named: "dice_6")
        }else{
            guard let diceValue = dice?.value else { return }
            let imageName = "dice_" + String(diceValue)
            diceImage.image = UIImage(named: imageName)
        }
        if(dice?.locked == true){
            diceImage.alpha = 0.5
        }else{
            diceImage.alpha = 1
            
        }
    }
}
