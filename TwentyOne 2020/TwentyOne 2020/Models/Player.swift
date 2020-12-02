//
//  Player.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation
import UIKit

class Player {

    var position: Position
    var makePercent = 50
    var drinkTiming = 3.0
    var hasBallBack = false
    var isOnLeftSide: Bool {
        return position.rawValue < 4
    }

    init(position: Position) {
        self.position = position
    }

    func chooseTarget(availableTargets: [Int]) -> Int {
        return availableTargets.randomElement() ?? 0
    }

    func getThrowDelay() -> Double {
        return Double.random(in: 1.01...2.00)
    }
}

