//
//  ViewController.swift
//  v2
//
//  Created by Isabelle Donsbach on 4/27/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var removePlayer: UIButton!
    @IBOutlet weak var addPlayer: UIButton!
    @IBOutlet weak var endGame: UIView!
    @IBOutlet weak var endGameLabel: UILabel!
    @IBOutlet weak var restart: UIButton!
    
    var curPlayers = 4
    var players: [Player] = []
    static var events: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        endGame.isHidden = true
        endGameLabel.isHidden = true
        restart.isHidden = true
        makePlayers()
        table.dataSource = self
        table.delegate = self
        removePlayer.setTitle("remove player", for: .normal)
        addPlayer.setTitle("add player", for: .normal)
        addConstraints()

    }
    
    func addConstraints() {
        removePlayer.translatesAutoresizingMaskIntoConstraints = false
        addPlayer.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(removePlayer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(removePlayer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(addPlayer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        constraints.append(addPlayer.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func makePlayers() {
        players = []
        for num in 1...curPlayers {
            let p: Player = Player.init(score: 20, name: "Player \(num)")
            players.append(p)
        }
    }
    
    @IBAction func historyButtonClick() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "historyVC") as! HistoryViewController
        present(vc, animated: true)
    }
    
    @IBAction func removePlayerClick() {
        if !isGameInProgress() {
            if curPlayers > 2 {
                curPlayers = curPlayers - 1
                makePlayers()
                table.reloadData()
            }
        }
    }
    
    @IBAction func addPlayerClick() {
        if !isGameInProgress() {
            if curPlayers < 8 {
                curPlayers = curPlayers + 1
                makePlayers()
                table.reloadData()
            }
        }
    }
    
    func isGameInProgress() -> Bool{
        for player in players {
            if player.score <= 0 {
                return false
            }
            if player.score != 20 {
                return true
            }
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        cell.configure(with: players[indexPath.row])
        cell.delegate = self
        //cell.label.text = players[indexPath.row].name
        //cell.minusButton.setTitle("-", for: .normal)
        //cell.plusButton.setTitle("+", for: .normal)
        //cell.minusCustomButton.setTitle("-5", for: .normal)
        //cell.plusCustomButton.setTitle("+5", for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / CGFloat(players.count) - 20
    }

    func isEndGame(player: Player) {
        if player.score <= 0 {
            endGameLabel.text = "\(player.name) LOSES!"
            restart.setTitle("Restart", for: .normal)
            endGame.isHidden = false
            endGameLabel.isHidden = false
            restart.isHidden = false
        }
    }
    
    @IBAction func restartClick() {
        curPlayers = 4
        makePlayers()
        ViewController.events = []
        endGame.isHidden = true
        endGameLabel.isHidden = true
        restart.isHidden = true
        table.reloadData()
    }
    
}

extension ViewController: PlayerTableViewCellDelegate {
    
    func minusButtonClick(with player: Player) {
        ViewController.events.append("\(player.name) lost one life.")
        player.change(-1)
        isEndGame(player: player)
    }
    
    func plusButtonClick(with player: Player) {
        ViewController.events.append("\(player.name) gained one life.")
        player.change(1)
    }
    
    func minusCustomButtonClick(with player: Player) {
        ViewController.events.append("\(player.name) lost five life.")
        player.change(-5)
        isEndGame(player: player)
    }
    
    func plusCustomButtonClick(with player: Player) {
        ViewController.events.append("\(player.name) gained five life.")
        player.change(5)
    }
}
    
    /*let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    var curPlayers = 4
    var players: [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        setupTableView()
        
        makePlayers()
        // Do any additional setup after loading the view.
    }
    
    func makePlayers() {
        players = []
        for _ in 1...curPlayers {
            let p: Player = Player.init(score: 20)
            players.append(p)
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(players[indexPath.row])")
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Optional("mainToHistory"):
            let secondVC = segue.destination as! HistoryViewController
            break;
        default:
            print("uhhh")
        }
    }*/


}

/*extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "\(players[indexPath.row].score)"
    return cell
  }
}
*/
*/
