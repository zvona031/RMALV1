//
//  ViewController.swift
//  BlackJack
//
//  Created by Zvonimir Pavlović on 18/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import UIKit

class BlackJackViewController: UIViewController,BlackJackViewDelegate {
   
    @IBOutlet weak var dealersResult: UILabel!
    @IBOutlet weak var playersResult: UILabel!
    @IBOutlet weak var playersCards: UIStackView!
    @IBOutlet weak var dealersCards: UIStackView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    
    lazy var viewModel: BlackJackViewViewModel = BlackJackViewViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    func setupUI(){
        startButton.addTarget(self, action: #selector(onStartClick), for: .touchUpInside)
        standButton.addTarget(self, action: #selector(onStandClick), for: .touchUpInside)
        hitButton.addTarget(self, action: #selector(onHitClick), for: .touchUpInside)
        draw(cardsView: playersCards)
        draw(cardsView: dealersCards)
    }
    
    @objc func onStartClick(){
        viewModel.startGame()
    }
    
    @objc func onHitClick(){
        viewModel.hitClicked()
    }
    
    @objc func onStandClick(){
        viewModel.standClicked()
    }
    
    func onGameStarted(playerCards: [String],dealerCards: [String]) {
        playerCards.forEach{ cardName in
            cardsUpdate(imageName: cardName,stackID: 1)
        }
        dealerCards.forEach { cardName in
            cardsUpdate(imageName: cardName,stackID: 2)
        }
        startButton.isHidden = true
        hitButton.isHidden = false
        standButton.isHidden = false
    }
    
    func cardsUpdate(imageName: String, stackID: Int) {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFit
        if (stackID == 1) {
            playersCards.addArrangedSubview(imageView)
        }else{
            dealersCards.addArrangedSubview(imageView)
        }
    }
    
    
    
    func turnDealersCardUpsideDown(imageName: String) {
        dealersCards.arrangedSubviews[0].removeFromSuperview()
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFit
        dealersCards.insertArrangedSubview(imageView, at: 0)
       }

    func updateFinalResults(playerResult: Int, dealerResult: Int,message: String) {
        self.playersResult.text = String(playerResult)
        self.dealersResult.text = String(dealerResult)
        makeResultAlert(message: message)
    }
    
    func updatePlayerResult(playerResult: Int) {
        self.playersResult.text = String(playerResult)
    }
    
    func makeResultAlert(message: String){
        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                self.resetUI()
              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")
        }}))
        self.present(alert, animated: true, completion: nil)

    }
    
    func resetUI(){
        hitButton.isHidden = true
        standButton.isHidden = true
        startButton.isHidden = false
        playersCards.arrangedSubviews.forEach{ view in
            view.removeFromSuperview()
        }
        dealersCards.arrangedSubviews.forEach{ view in
            view.removeFromSuperview()
        }
        playersResult.text = "Your result"
        dealersResult.text = "Dealers result"
    }
    
    func playerLoses(playerResult: Int, message: String) {
        self.updatePlayerResult(playerResult: playerResult)
        makeResultAlert(message: message)
    }
    
    func draw(cardsView: UIView){
        let viewSize = cardsView.frame
        let rectangle = CGRect(x: viewSize.minX - 5, y: viewSize.minY - 5, width: viewSize.width + 10,height: viewSize.height + 10)
        let view = UIView(frame: rectangle)
        self.view.addSubview(view)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.yellow.withAlphaComponent(0.75).cgColor
    }
    
}

