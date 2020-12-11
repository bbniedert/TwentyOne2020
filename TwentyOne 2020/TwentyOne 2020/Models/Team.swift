//
//  Team.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/10/20.
//

import Foundation

class Team: Codable {
    let name: String
    let leftPlayer: Player
    let centerPlayer: Player
    let rightPlayer: Player
    init(name: String, leftPlayer: Player, centerPlayer: Player, rightPlayer: Player) {
        self.name = name
        self.leftPlayer = leftPlayer
        self.centerPlayer = centerPlayer
        self.rightPlayer = rightPlayer
    }
}
