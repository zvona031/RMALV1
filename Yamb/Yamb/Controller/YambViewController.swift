//
//  ViewController.swift
//  Yamb
//
//  Created by Zvonimir Pavlović on 17/04/2020.
//  Copyright © 2020 Zvonimir Pavlović. All rights reserved.
//

import UIKit

class YambViewController: UIViewController, YambViewModelDelegate {

    @IBOutlet weak var dicesCollectionView: UICollectionView!
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    let viewModel : YambViewViewModel = YambViewViewModel()
    let cellIdentifier = "DiceCell"
    var layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setLayout()
        setRollButton()
    }
    
    func setRollButton(){
        rollButton.addTarget(self, action: #selector(onRollClicked), for: .touchUpInside)
    }
    
    @objc func onRollClicked(){
        viewModel.rollClicked()
    }
    
    func setLayout(){
        if layout == nil {
            let numberOfItemsForRow: CGFloat = 2
            let numberOfItemsForColumn: CGFloat = 3
            let lineSpacing: CGFloat = 0
            let interItemSpacing: CGFloat = 0
            let width = (dicesCollectionView.safeAreaLayoutGuide.layoutFrame.width) / numberOfItemsForRow
            let height = (dicesCollectionView.safeAreaLayoutGuide.layoutFrame.height) / numberOfItemsForColumn
            
            layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: width, height: height)
            layout.sectionInset = UIEdgeInsets.zero
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = lineSpacing
            layout.minimumInteritemSpacing = interItemSpacing

            self.dicesCollectionView.setCollectionViewLayout(layout, animated: true)
        }
    }

    func updateDiceImages() {
        dicesCollectionView.reloadData()
        if(viewModel.rolled == 0){
            infoLabel.text = viewModel.result
        }else{
            infoLabel.text = String(viewModel.rolled)
        }
        
    }
    
    func updateResultLabel(){
        
    }
    
    
}

extension YambViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DiceCell
        cell.dice = viewModel.dices[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dice = viewModel.dices[indexPath.row]
        viewModel.diceClicked(dice: dice)
    }
}
