//
//  Player.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation

class Player {

    weak var delegate: Pair?

    func throwBall() {
        let result = Int.random(in: 0...1)
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            self.delegate?.playerDidThrow(success: result == 1)
        }
    }
}
