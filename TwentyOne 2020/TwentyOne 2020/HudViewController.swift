//
//  HudViewController.swift
//  TwentyOne 2020
//
//  Created by Brandon Niedert on 11/30/20.
//

import UIKit

protocol MatchDelegate: class {
    func didMakeRightCup()
    func didMakeLeftCup()
    func throwNextBall(previousThrower: Player)
    func startDrinkCountdown(player: Player,  completion: @escaping () -> Void)
}

class HudViewController: UIViewController {

    @IBOutlet weak var leftCupsRemainingLabel: UILabel!
    @IBOutlet weak var rightCupsRemainingLabel: UILabel!
    @IBOutlet weak var leftBallsBackLabel: UILabel!
    @IBOutlet weak var rightBallsBackLabel: UILabel!
    
    @IBOutlet weak var topRightDrinkView: UIView!
    @IBOutlet weak var topRightDrinkWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerRightDrinkView: UIView!
    @IBOutlet weak var centerRightDrinkWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomRightDrinkView: UIView!
    @IBOutlet weak var bottomRightDrinkWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var topLeftDrinkView: UIView!
    @IBOutlet weak var topLeftDrinkWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerLeftDrinkView: UIView!
    @IBOutlet weak var centerLeftDrinkWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLeftDrinkView: UIView!
    @IBOutlet weak var bottomLeftDrinkWidthConstraint: NSLayoutConstraint!

    var leftCupsRemaining = 21
    var rightCupsRemaining = 21
    var matchViewController: MatchViewController?

    var player1: Player?
    var player2: Player?
    var player3: Player?
    var player4: Player?
    var player5: Player?
    var player6: Player?

    var currentDrinkers = [Player]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let childController = children.first as? MatchViewController {
            matchViewController = childController
            matchViewController?.delegate = self
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        player1 = Player(position: .topLeft)
        player2 = Player(position: .centerLeft)
        player3 = Player(position: .bottomLeft)
        player4 = Player(position: .topRight)
        player5 = Player(position: .centerRight)
        player6 = Player(position: .bottomRight)
    }
    
    @IBAction func startMatch(_ sender: UIButton) {
        sender.isHidden = true
        if let player1 = player1, let player5 = player5, let player3 = player3, let _ = player2, let _ = player4, let _ = player6, let match = matchViewController {
            match.throwBall(thrower: player1)
            match.throwBall(thrower: player5)
            match.throwBall(thrower: player3)
        }
    }

    private func checkForBallsBack() -> Bool {
        if currentDrinkers.count == 3 {
            if currentDrinkers.contains(where: { $0.position == .topLeft }) &&
                currentDrinkers.contains(where: { $0.position == .centerLeft }) &&
                currentDrinkers.contains(where: { $0.position == .bottomLeft }) {
                rightBallsBackLabel.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                    self.rightBallsBackLabel.isHidden = true
                })
                return true
            } else if currentDrinkers.contains(where: { $0.position == .topRight }) &&
                        currentDrinkers.contains(where: { $0.position == .centerRight }) &&
                        currentDrinkers.contains(where: { $0.position == .bottomRight }) {
                leftBallsBackLabel.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                    self.leftBallsBackLabel.isHidden = true
                })
                return true
            }
        }
        return false
    }
}

extension HudViewController: MatchDelegate {
    func didMakeLeftCup() {
        leftCupsRemaining -= 1
        leftCupsRemainingLabel.text = "\(leftCupsRemaining)"
    }

    func didMakeRightCup() {
        rightCupsRemaining -= 1
        rightCupsRemainingLabel.text = "\(rightCupsRemaining)"
    }

    func throwNextBall(previousThrower: Player) {
        var nextThrower: Player?
        switch previousThrower.position {
        case .topLeft:
            nextThrower = player4
        case .centerLeft:
            nextThrower = player5
        case .bottomLeft:
            nextThrower = player6
        case .topRight:
            nextThrower = player1
        case .centerRight:
            nextThrower = player2
        case .bottomRight:
            nextThrower = player3
        }

        guard let match = matchViewController, let thrower = nextThrower else { return }
        if previousThrower.hasBallBack {
            previousThrower.hasBallBack = false
            match.throwBall(thrower: previousThrower)
        } else {
            match.throwBall(thrower: thrower)
        }
    }

    func startDrinkCountdown(player: Player, completion: @escaping () -> Void) {
        var constraintToChange: NSLayoutConstraint?
        var drinkView: UIView?
        var currentDrinker: Player?
        switch player.position {
        case .topLeft:
            currentDrinker = player4
            constraintToChange = topRightDrinkWidthConstraint
            drinkView = topRightDrinkView
        case .centerLeft:
            currentDrinker = player5
            constraintToChange = centerRightDrinkWidthConstraint
            drinkView = centerRightDrinkView
        case .bottomLeft:
            currentDrinker = player6
            constraintToChange = bottomRightDrinkWidthConstraint
            drinkView = bottomRightDrinkView
        case .topRight:
            currentDrinker = player1
            constraintToChange = topLeftDrinkWidthConstraint
            drinkView = topLeftDrinkView
        case .centerRight:
            currentDrinker = player2
            constraintToChange = centerLeftDrinkWidthConstraint
            drinkView = centerLeftDrinkView
        case .bottomRight:
            currentDrinker = player3
            constraintToChange = bottomLeftDrinkWidthConstraint
            drinkView = bottomLeftDrinkView
        }

        if let constraint = constraintToChange, let drinkView = drinkView, let currentDrinker = currentDrinker {
            currentDrinkers.append(currentDrinker)

            if checkForBallsBack() {
                matchViewController?.gotBallsBack(leftSide: player.isOnLeftSide)
                if player.isOnLeftSide {
                    player1?.hasBallBack = true
                    player2?.hasBallBack = true
                    player3?.hasBallBack = true
                } else {
                    player4?.hasBallBack = true
                    player5?.hasBallBack = true
                    player6?.hasBallBack = true
                }
            }

            drinkView.isHidden = false
            constraint.constant = 0
            UIView.animate(withDuration: player.drinkTiming, animations: {
                self.view.layoutSubviews()
            }, completion: { _ in
                constraint.constant = 200
                drinkView.isHidden = true
                self.currentDrinkers = self.currentDrinkers.filter({ $0.position != currentDrinker.position })
                completion()
            })
        }
    }
}
