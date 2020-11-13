//
//  Match.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation

class Match {

    let leftPair: Pair
    let centerPair: Pair
    let rightPair: Pair

    init(leftPair: Pair, centerPair: Pair, rightPair: Pair) {
        self.leftPair = leftPair
        self.centerPair = centerPair
        self.rightPair = rightPair
    }
}
