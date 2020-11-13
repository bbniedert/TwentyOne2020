//
//  Pair.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/13/20.
//

import Foundation
import UIKit

protocol PlayerDelegate: class {
    func playerDidThrow(success: Bool, target: Int)
}

enum BallState {
    case leftPlayer
    case rightPlayer
}

struct PairUI {
    let leftLabel: UILabel
    let rightLabel: UILabel
    let leftScoreLabel: UILabel
    let rightScoreLabel: UILabel
    let rightBall: UIImageView
    let leftBall: UIImageView
    let leftRack: RackView
    let rightRack: RackView

    init(leftLabel: UILabel, rightLabel: UILabel, leftScore: UILabel, rightScore: UILabel, leftBall: UIImageView, rightBall: UIImageView, leftRack: RackView, rightRack: RackView) {
        self.leftLabel = leftLabel
        self.rightLabel = rightLabel
        leftScoreLabel = leftScore
        rightScoreLabel = rightScore
        self.leftBall = leftBall
        self.rightBall = rightBall
        self.leftRack = leftRack
        self.rightRack = rightRack
    }
}

class Pair {
    let leftPlayer: Player
    let rightPlayer: Player
    var ballState: BallState
    let ui: PairUI

    private var shouldStop = false

    weak var delegate: PairDelegate?

    var randomWaitValue: Double {
        return Double.random(in: 0.25 ... 1.0)
    }

    init(leftPlayer: Player, rightPlayer: Player, ballState: BallState, ui: PairUI, delegate: PairDelegate) {
        self.leftPlayer = leftPlayer
        self.rightPlayer = rightPlayer
        self.ballState = ballState
        self.ui = ui
        self.delegate = delegate
    }

    func start() {
        leftPlayer.delegate = self
        rightPlayer.delegate = self
        DispatchQueue.global().async {
            self.progressGame()
        }
    }

    func stop() {
        shouldStop = true
    }

    private func progressGame() {
        if !shouldStop {
            let thrower = self.ballState == .leftPlayer ? self.leftPlayer : self.rightPlayer
            let label = self.ballState == .leftPlayer ? self.ui.leftLabel : self.ui.rightLabel
            let ball = self.ballState == .leftPlayer ? self.ui.leftBall : self.ui.rightBall
            let availableTargets = self.ballState == .leftPlayer ? MatchManager.instance.rightCupsAvailable : MatchManager.instance.leftCupsAvailable
            let rack = self.ballState == .leftPlayer ? self.ui.rightRack : self.ui.leftRack
//            ball.isHidden = false
            DispatchQueue.global().asyncAfter(deadline: .now() + randomWaitValue) {
                DispatchQueue.main.async {
                    guard let target = availableTargets.randomElement() else { return }
                    thrower.throwBall(target: target, location: rack.getCupCenter(cupNumber: target), ball: ball)
                    label.text = "THROWING..."
                }
            }
        }
    }
}

extension Pair: PlayerDelegate {
    func playerDidThrow(success: Bool, target: Int) {
        if !shouldStop {
            let throwerSide = ballState
            ballState = ballState == .leftPlayer ? .rightPlayer : .leftPlayer
            let throwerLabel = throwerSide == .leftPlayer ? ui.leftLabel : ui.rightLabel
            let receiverLabel = throwerSide == .leftPlayer ? ui.rightLabel : ui.leftLabel
            let scoreLabel = throwerSide == .leftPlayer ? ui.rightScoreLabel : ui.leftScoreLabel
            DispatchQueue.main.async {
                throwerLabel.text = success ? "MAKE!" : "MISS!"
                receiverLabel.text = success ? "DRINKING!" : "HAS BALL"
                if success, let currentScore = Int(scoreLabel.text ?? "") {
                    let newScore = currentScore - 1
                    scoreLabel.text = "\(newScore)"
                    self.delegate?.didMakeCup(leftSide: throwerSide == .leftPlayer, cupNumber: target)
                    if newScore == 0 {
                        self.delegate?.endMatch(leftSideWon: throwerSide == .leftPlayer)
                    }
                }
            }

            progressGame()
        }
    }
}
