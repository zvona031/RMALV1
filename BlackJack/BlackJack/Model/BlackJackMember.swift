//
//  BlackJackMember.swift
//  BlackJack
//
//  Created by Zvonimir Pavlović on 19/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import Foundation

protocol BlackJackMember: class {
    func initialPull()
    func pullSingleCard() -> String
    func calculateResult()
    func returnInitialCardNames() -> [String]
    func getResult() -> Int
    func reset()
}
