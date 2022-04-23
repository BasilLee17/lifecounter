//
//  ViewController.swift
//  LifeCounter
//
//  Created by Isabelle Donsbach on 4/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    var p1Label: UILabel!
    var score1Label: UILabel!
    var p1minusButton: UIButton!
    var p1plusButton: UIButton!
    var p1minusFiveButton: UIButton!
    var p1plusFiveButton: UIButton!
    
    var p2Label: UILabel!
    var score2Label: UILabel!
    var p2minusButton: UIButton!
    var p2plusButton: UIButton!
    var p2minusFiveButton: UIButton!
    var p2plusFiveButton: UIButton!
    
    var loserLabel: UILabel!
    var resetButton: UIButton!
    
    var p1score = 20
    var p2score = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth : CGFloat = UIScreen.main.bounds.width - 40
        let screenHeight : CGFloat = UIScreen.main.bounds.height - 60

        //player labels
        p1Label = UILabel(frame: CGRect(x: screenWidth/2 - 5, y: (screenHeight/4) - 30, width: 100, height: 20))
        p1Label.text = "Player 1"
        view.addSubview(p1Label)
        p2Label = UILabel(frame: CGRect(x: screenWidth/2 - 5, y: (3*screenHeight/4) - 30, width: 100, height: 20))
        p2Label.text = "Player 2"
        view.addSubview(p2Label)
        
        //score labels
        score1Label = UILabel(frame: CGRect(x: screenWidth/2 - 5, y: (screenHeight/4) + 30, width: 100, height: 20))
        score1Label.text = "Life: \(p1score)"
        score2Label = UILabel(frame: CGRect(x: screenWidth/2 - 5, y: ((3 * screenHeight)/4) + 30, width: 100, height: 20))
        score2Label.text = "Life: \(p2score)"
        view.addSubview(score1Label)
        view.addSubview(score2Label)
        
        //game end
        loserLabel = UILabel(frame: CGRect(x: screenWidth/3 - 20, y: screenHeight - 20, width: 150, height: 20))
        loserLabel.isHidden = true
        loserLabel.text = "Player X LOSES!"
        view.addSubview(loserLabel)
        resetButton = makeButton(text: "reset", x: 2*screenWidth/3, y: screenHeight - 22, width: 70, height: 25, method: #selector(resetButtonClick(_:)))
        resetButton.isHidden = true

        //plus and minus buttons
        p1minusButton = makeButton(text: "-", x: screenWidth/3 - 15, y: (screenHeight/4), width: 35, height: 25, method: #selector(p1minusButtonClick(_:)))
        p1plusButton = makeButton(text: "+", x: 2*screenWidth/3 + 20, y: (screenHeight/4), width: 35, height: 25, method: #selector(p1plusButtonClick(_:)))
        p1minusFiveButton = makeButton(text: "-5", x: screenWidth/3 - 20, y: (screenHeight/4) + 60, width: 45, height: 25, method: #selector(p1minusFiveButtonClick(_:)))
        p1plusFiveButton = makeButton(text: "+5", x: 2*screenWidth/3 + 15, y: (screenHeight/4) + 60, width: 45, height: 25, method: #selector(p1plusFiveButtonClick(_:)))
        p2minusButton = makeButton(text: "-", x: screenWidth/3 - 15, y: (3*screenHeight/4), width: 35, height: 25, method: #selector(p2minusButtonClick(_:)))
        p2plusButton = makeButton(text: "+", x: 2*screenWidth/3 + 20, y: (3*screenHeight/4), width: 35, height: 25, method: #selector(p2plusButtonClick(_:)))
        p2minusFiveButton = makeButton(text: "-5", x: screenWidth/3 - 20, y: (3*screenHeight/4) + 60, width: 45, height: 25, method: #selector(p2minusFiveButtonClick(_:)))
        p2plusFiveButton = makeButton(text: "+5", x: 2*screenWidth/3 + 15, y: (3*screenHeight/4) + 60, width: 45, height: 25, method: #selector(p2plusFiveButtonClick(_:)))
    }
    
    func makeButton(text: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, method: Selector) -> UIButton {
        let button = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        button.configuration = UIButton.Configuration.filled()
        button.setTitle("\(text)", for: .normal)
        button.addTarget(self, action: method, for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }
    
    func changeScore(_ player: Int) {
        if player == 1 {
            score1Label.text = "Score: \(p1score)"
            if p1score <= 0 {
                loserLabel.text = "Player 1 LOSES!"
                loserLabel.isHidden = false
                resetButton.isHidden = false
            }
        } else {
            score2Label.text = "Score: \(p2score)"
            if p2score <= 0 {
                loserLabel.text = "Player 2 LOSES!"
                loserLabel.isHidden = false
                resetButton.isHidden = false
            }
        }
    }
    
    @objc func resetButtonClick(_ sender: UIButton) {
        p1score = 20
        p2score = 20
        changeScore(1)
        changeScore(2)
        loserLabel.isHidden = true
        resetButton.isHidden = true
    }
    
    @objc func p1minusButtonClick(_ sender: UIButton) {
        p1score = p1score - 1
        changeScore(1)
    }
    @objc func p1plusButtonClick(_ sender: UIButton) {
        p1score = p1score + 1
        changeScore(1)
    }
    @objc func p1minusFiveButtonClick(_ sender: UIButton) {
        p1score = p1score - 5
        changeScore(1)
    }
    @objc func p1plusFiveButtonClick(_ sender: UIButton) {
        p1score = p1score + 5
        changeScore(1)
    }
    @objc func p2minusButtonClick(_ sender: UIButton) {
        p2score = p2score - 1
        changeScore(2)
    }
    @objc func p2plusButtonClick(_ sender: UIButton) {
        p2score = p2score + 1
        changeScore(2)
    }
    @objc func p2minusFiveButtonClick(_ sender: UIButton) {
        p2score = p2score - 5
        changeScore(2)
    }
    @objc func p2plusFiveButtonClick(_ sender: UIButton) {
        p2score = p2score + 5
        changeScore(2)
    }
}
