//
//  Player.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation

class Player {

    weak var delegate: Pair?
    let isLeftSidePlayer: Bool

    var playerNumber = Int.random(in: 1...1000)

    init(isLeftSidePlayer: Bool) {
        self.isLeftSidePlayer = isLeftSidePlayer
    }

    func throwBall() {
        let availableTargets = isLeftSidePlayer ? MatchManager.instance.rightCupsAvailable : MatchManager.instance.leftCupsAvailable
        guard let target = availableTargets.randomElement() else { return }
        let result = Int.random(in: 0...1)
        print("Player \(playerNumber) threw at target \(target), result: \(result)")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let updatedTargets = self.isLeftSidePlayer ? MatchManager.instance.rightCupsAvailable : MatchManager.instance.leftCupsAvailable
            if updatedTargets.contains(target) && result == 1 {
                MatchManager.instance.removeCup(leftShooter: self.isLeftSidePlayer, target: target)
            }
            self.delegate?.playerDidThrow(success: result == 1, target: target)
        }
    }
}

