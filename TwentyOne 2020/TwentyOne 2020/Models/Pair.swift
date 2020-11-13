//
//  Pair.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation
import UIKit

protocol PlayerDelegate: class {
    func playerDidThrow(success: Bool)
}

enum BallState {
    case leftPlayer
    case rightPlayer
}

class Pair {
    let leftPlayer: Player
    let rightPlayer: Player
    var ballState: BallState
    let leftLabel: UILabel
    let rightLabel: UILabel

    weak var delegate: PairDelegate?

    var randomWaitValue: Double {
        return Double.random(in: 0.25 ... 1.5)
    }

    init(leftPlayer: Player, rightPlayer: Player, ballState: BallState, leftLabel: UILabel, rightLabel: UILabel, delegate: PairDelegate) {
        self.leftPlayer = leftPlayer
        self.rightPlayer = rightPlayer
        self.ballState = ballState
        self.leftLabel = leftLabel
        self.rightLabel = rightLabel
        self.delegate = delegate
    }

    func start() {
        leftPlayer.delegate = self
        rightPlayer.delegate = self
        DispatchQueue.global().async {
            self.progressGame()
        }
    }

    private func progressGame() {
        let thrower = self.ballState == .leftPlayer ? self.leftPlayer : self.rightPlayer
        let label = self.ballState == .leftPlayer ? self.leftLabel : self.rightLabel
        DispatchQueue.global().asyncAfter(deadline: .now() + randomWaitValue) {
            thrower.throwBall()
            DispatchQueue.main.async {
                label.text = "THROWING..."
            }
        }
    }
}

extension Pair: PlayerDelegate {
    func playerDidThrow(success: Bool) {
        delegate?.ballWasThrown(success: success)
        let throwerLabel = ballState == .leftPlayer ? leftLabel : rightLabel
        let receiverLabel = ballState == .leftPlayer ? rightLabel : leftLabel
        ballState = ballState == .leftPlayer ? .rightPlayer : .leftPlayer
        DispatchQueue.main.async {
            throwerLabel.text = success ? "MAKE!" : "MISS!"
            receiverLabel.text = success ? "DRINKING!" : "HAS BALL"
        }

        progressGame()
    }
}
