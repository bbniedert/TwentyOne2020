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
    var shootingStyle: ShootingStyle
    var targetStrategy: TargetStrategy
    var hasBallBack = false

    var isOnLeftSide: Bool {
        return position.rawValue < 4
    }

    init(position: Position, shootingStyle: ShootingStyle, targetStrategy: TargetStrategy) {
        self.position = position
        self.shootingStyle = shootingStyle
        self.targetStrategy = targetStrategy
    }

    func chooseTarget(availableTargets: [Int]) -> Int {
        return availableTargets.randomElement() ?? 0
    }

    func getThrowDelay() -> Double {
        return Double.random(in: 1.01...2.00)
    }

    func getThrowDuration() -> Double {
        return 0.0
    }
}

