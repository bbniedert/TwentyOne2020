//
//  Team.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/10/20.
//

import Foundation

class Team: Codable {
    let name: String
    var leftPlayer: Player
    var centerPlayer: Player
    var rightPlayer: Player
    var wins = 0
    var losses = 0
    var cd = 0
    init(name: String, leftPlayer: Player, centerPlayer: Player, rightPlayer: Player) {
        self.name = name
        self.leftPlayer = leftPlayer
        self.centerPlayer = centerPlayer
        self.rightPlayer = rightPlayer
    }

    func splitCups(cups: Int) {
        let wholeCups = cups/3
        let remainder = cups%3
        if remainder != 0 {
            let num = Int.random(in: 1...3)
            if remainder == 1 {
                if num == 1 {
                    leftPlayer.cupsDrank += 1
                } else if num == 2 {
                    centerPlayer.cupsDrank += 1
                } else {
                    rightPlayer.cupsDrank += 1
                }
            } else {
                if num == 1 {
                    leftPlayer.cupsDrank += 1
                    centerPlayer.cupsDrank += 1
                } else if num == 2 {
                    centerPlayer.cupsDrank += 1
                    rightPlayer.cupsDrank += 1
                } else {
                    leftPlayer.cupsDrank += 1
                    rightPlayer.cupsDrank += 1
                }
            }
        }

        leftPlayer.cupsDrank += wholeCups
        centerPlayer.cupsDrank += wholeCups
        rightPlayer.cupsDrank += wholeCups
    }
}
