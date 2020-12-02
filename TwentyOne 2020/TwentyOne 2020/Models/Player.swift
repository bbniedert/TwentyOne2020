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
    var shootingPercentage = 50.0
    var drinkTiming = 3.0
    var shootingStyle: ShootingStyle
    var targetStrategy: TargetStrategy
    var hasBallBack = false
    var madeCups = 0

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

    func getShootingPercentage(target: Int) -> Double {

        var rowModifier = 0.0
        if (1...6).contains(target) {
            rowModifier = RowShootingPercentModifier.row6.rawValue
        } else if (7...11).contains(target) {
            rowModifier = RowShootingPercentModifier.row5.rawValue
        } else if (12...15).contains(target) {
            rowModifier = RowShootingPercentModifier.row4.rawValue
        } else if (16...18).contains(target) {
            rowModifier = RowShootingPercentModifier.row3.rawValue
        } else if (19...20).contains(target) {
            rowModifier = RowShootingPercentModifier.row2.rawValue
        } else {
            rowModifier = RowShootingPercentModifier.row1.rawValue
        }

        return shootingPercentage + rowModifier
    }

    func getThrowDelay() -> Double {
        return Double.random(in: 1.01...2.00)
    }

    func getThrowDuration() -> Double {
        return 0.0
    }
}

