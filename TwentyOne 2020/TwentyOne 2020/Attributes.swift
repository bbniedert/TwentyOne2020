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

enum RowShootingPercentModifier: Int {
    case row1 = 15
    case row2 = 10
    case row3 = 5
    case row4 = 0
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
}

enum ShootingStyle: Int {
    case normal = 0
    case laser = 1
    case loft = 2
}
