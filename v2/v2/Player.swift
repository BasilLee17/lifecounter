//
//  Players.swift
//  v2
//
//  Created by Isabelle Donsbach on 4/27/22.
//

import Foundation

class Player {
    
    var score : Int
    var name : String
    
    init(score: Int, name : String) {
        self.score = score
        self.name = name
    }
    
    func change(_ num: Int) {
        score = score + num
    }
}
