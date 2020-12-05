//
//  Attributes.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 12/1/20.
//

import Foundation

enum Position: Int {
    case topLeft = 1
    case centerLeft = 2
    case bottomLeft = 3
    case topRight = 4
    case centerRight = 5
    case bottomRight = 6
}

enum RowShootingPercentModifier: Double {
    case row1 = 15
    case row2 = 10
    case row3 = 2.5
    case row4 = -2.5
    case row5 = -5
    case row6 = -10
}

enum TargetStrategy: Int {
    case frontFirst = 0
    case backLeftFirst = 1
    case backRightFirst = 2
    case honeycombFront = 3
    case honeycombLeft = 4
    case honeycombRight = 5
    case random = 6

    func getTarget(availableCups: [Int]) -> Int {
        switch self {
        case .frontFirst:
            return availableCups.reversed().first ?? 0
        case .backLeftFirst:
            let backRow = [6,5,4,3,2,1].filter({ availableCups.contains($0) })
            if backRow.count > 0 {
                return backRow.first ?? 0
            }

            let secondRow = [11,10,9,8,7].filter({ availableCups.contains($0) })
            if secondRow.count > 0 {
                return secondRow.first ?? 0
            }

            return availableCups.randomElement() ?? 0
        case .backRightFirst:
            let backRow = [1,2,3,4,5,6].filter({ availableCups.contains($0) })
            if backRow.count > 0 {
                return backRow.first ?? 0
            }

            let secondRow = [7,8,9,10,11].filter({ availableCups.contains($0) })
            if secondRow.count > 0 {
                return secondRow.first ?? 0
            }

            return availableCups.randomElement() ?? 0
        case .honeycombFront:
            let primaryTargets = [21,20,19,18,17,16].filter({ availableCups.contains($0) })
            if primaryTargets.count > 0 {
                return primaryTargets.first ?? 0
            }

            let secondaryTargets = [1,2,5,6,7,11,12,15].filter({ availableCups.contains($0) })
            if secondaryTargets.count > 0 {
                return secondaryTargets.randomElement() ?? 0
            }

            let honeyComb = [3,4,8,9,10,13,14].filter({ availableCups.contains($0) })
            if honeyComb.count > 0 {
                return honeyComb.randomElement() ?? 0
            }

            return availableCups.randomElement() ?? 0
        case .honeycombLeft:
            let primaryTargets = [5,6,11,15].filter({ availableCups.contains($0) })
            if primaryTargets.count > 0 {
                return primaryTargets.first ?? 0
            }

            let secondaryTargets = [1,2,7,12,16,17,18,19,20,10].filter({ availableCups.contains($0) })
            if secondaryTargets.count > 0 {
                return secondaryTargets.randomElement() ?? 0
            }

            let honeyComb = [3,4,8,9,10,13,14].filter({ availableCups.contains($0) })
            if honeyComb.count > 0 {
                return honeyComb.randomElement() ?? 0
            }

            return availableCups.randomElement() ?? 0
        case .honeycombRight:
            let primaryTargets = [1,2,7,12].filter({ availableCups.contains($0) })
            if primaryTargets.count > 0 {
                return primaryTargets.first ?? 0
            }

            let secondaryTargets = [5,6,11,15,16,17,18,19,20,10].filter({ availableCups.contains($0) })
            if secondaryTargets.count > 0 {
                return secondaryTargets.randomElement() ?? 0
            }

            let honeyComb = [3,4,8,9,10,13,14].filter({ availableCups.contains($0) })
            if honeyComb.count > 0 {
                return honeyComb.randomElement() ?? 0
            }

            return availableCups.randomElement() ?? 0
        case .random:
            return availableCups.randomElement() ?? 0
        }
    }
}

enum ShootingStyle: Int {
    case normal = 0
    case laser = 1
    case loft = 2
}
