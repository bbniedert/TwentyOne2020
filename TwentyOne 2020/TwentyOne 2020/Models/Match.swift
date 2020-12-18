//
//  Match.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/13/20.
//

import Foundation

enum Winner: Int, Codable {
    case left
    case right
    case none
}

class Match: Codable {

    let leftTeam: Team
    let rightTeam: Team
    var cupDifferential = 0
    var winner = Winner.none

    init(leftTeam: Team, rightTeam: Team) {
        self.leftTeam = leftTeam
        self.rightTeam = rightTeam
    }
}
