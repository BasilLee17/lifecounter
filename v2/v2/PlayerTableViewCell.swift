//
//  PlayerTableViewCell.swift
//  v2
//
//  Created by Isabelle Donsbach on 4/27/22.
//

import UIKit

protocol PlayerTableViewCellDelegate: AnyObject {
    func minusButtonClick(with player: Player)
    func plusButtonClick(with player: Player)
    func minusCustomButtonClick(with player: Player)
    func plusCustomButtonClick(with player: Player)
}

class PlayerTableViewCell: UITableViewCell {
    
    weak var delegate: PlayerTableViewCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusCustomButton: UIButton!
    @IBOutlet weak var plusCustomButton: UIButton!
    
    private var player: Player!
    
    func configure(with player: Player) {
        if label != nil {
            self.player = player
            label.text = "\(player.name)"
            score.text = "Score: \(player.score)"
            minusButton.setTitle("-", for: .normal)
            plusButton.setTitle("+", for: .normal)
            minusCustomButton.setTitle("-5", for: .normal)
            plusCustomButton.setTitle("+5", for: .normal)
        }
    }
    
    @IBAction func minusButtonClick() {
        delegate?.minusButtonClick(with: player)
        score.text = "Score: \(player.score)"
    }
    
    @IBAction func plusButtonClick() {
        delegate?.plusButtonClick(with: player)
        score.text = "Score: \(player.score)"
    }
    
    @IBAction func minusCutomButtonClick() {
        delegate?.minusCustomButtonClick(with: player)
        score.text = "Score: \(player.score)"
    }
    
    @IBAction func plusCustomButtonClick() {
        delegate?.plusCustomButtonClick(with: player)
        score.text = "Score: \(player.score)"
    }
    
}
