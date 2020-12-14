//
//  Player.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation
import UIKit

class Player: Codable {

    var position: TablePosition
    var name: String
    var shootingPercentage: Double
    var drinkTiming: Double
    var shootingStyle: ShootingStyle
    var targetStrategy: TargetStrategy
    var hasBallBack = false
    var tankStatus: TankStatus
    var madeCups = 0
    var shotsTaken = 0
    var cupsDrank = 0
    var currentGameCupsMade = 0

    var shotPercent: String {
        let percent = (Double(madeCups)/Double(shotsTaken)) * 100.0
        return String(format: "%.2f%", percent)
    }

    var isOnLeftSide: Bool {
        return position.rawValue < 4
    }

    init(name: String, position: TablePosition = .centerLeft, shootingStyle: ShootingStyle, targetStrategy: TargetStrategy, drinkTiming: Double = 3.0, shootingPercentage: Double = 30.0, tankStatus: TankStatus = .none) {
        self.position = position
        self.shootingStyle = shootingStyle
        self.targetStrategy = targetStrategy
        self.drinkTiming = drinkTiming
        self.name = name
        self.shootingPercentage = shootingPercentage
        self.tankStatus = tankStatus
    }

    func chooseTarget(availableTargets: [Int]) -> Int {
        return self.targetStrategy.getTarget(availableCups: availableTargets)
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
        return Double.random(in: 0.2...1.0)
    }

    func getThrowDuration() -> Double {
        return 0.0
    }
}

