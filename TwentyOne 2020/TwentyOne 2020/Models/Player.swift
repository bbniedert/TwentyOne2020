//
//  Player.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation
import UIKit

enum Streak: Double, Codable {
    case normal = 0.0
    case warm = 5.0
    case hot = 10.0
    case cool = -5.0
    case cold = -10.0
}

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
    var clutchCup = 0
    var streak: Streak = .normal

    var shotPercent: Double {
        if shotsTaken > 0 {
            return (Double(madeCups)/Double(shotsTaken)) * 100.0
        }
        return 0.0
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

        return shootingPercentage + rowModifier - getDrunkModifier() + streak.rawValue
    }

    func rollForHotStreak() {
        let roll = Int.random(in: 1...10)
        if roll == 10 {
            streak = .hot
        } else if roll == 9 {
            streak = .warm
        } else if roll == 2 {
            streak = .cool
        } else if roll == 1 {
            streak = .cold
        } else {
            streak = .normal
        }
    }

    func getColorForStreak() -> UIColor {
        switch streak {
        case .normal:
            return UIColor.white
        case .warm:
            return UIColor.orange
        case .hot:
            return UIColor.red
        case .cool:
            return UIColor.cyan
        case .cold:
            return UIColor.blue
        }
    }

    func getDrunkModifier() -> Double {
        let startingCount = tankStatus.rawValue * 7
        if cupsDrank > startingCount {
            let effectiveCups = (cupsDrank - startingCount) / 21
            return Double(effectiveCups)
        } else {
            return 0.0
        }
    }

    func getThrowDelay() -> Double {
        return Double.random(in: 0.2...1.5)
    }

    func getThrowDuration() -> Double {
        return 0.0
    }
}

