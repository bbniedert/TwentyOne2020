//
//  Player.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation
import UIKit

class Player {

    weak var delegate: Pair?
    let isLeftSidePlayer: Bool

    var playerNumber = Int.random(in: 1...1000)

    init(isLeftSidePlayer: Bool) {
        self.isLeftSidePlayer = isLeftSidePlayer
    }

    func throwBall(target: Int, location: CGPoint, ball: UIImageView) {
        let result = Int.random(in: 0...1)
        print("Player \(playerNumber) threw at target \(target), result: \(result)")

        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                ball.center = location
            }, completion: { _ in
                let updatedTargets = self.isLeftSidePlayer ? MatchManager.instance.rightCupsAvailable : MatchManager.instance.leftCupsAvailable
                if updatedTargets.contains(target) && result == 1 {
                    MatchManager.instance.removeCup(leftShooter: self.isLeftSidePlayer, target: target)
                    self.delegate?.playerDidThrow(success: true, target: target)
                } else {
                    self.delegate?.playerDidThrow(success: false, target: target)
                }
            })
        }
    }
}

