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
    init(name: String, leftPlayer: Player, centerPlayer: Player, rightPlayer: Player) {
        self.name = name
        self.leftPlayer = leftPlayer
        self.centerPlayer = centerPlayer
        self.rightPlayer = rightPlayer
    }
}
