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
        match.throwBall(thrower: thrower)
    }

    func startDrinkCountdown(player: Player, completion: @escaping () -> Void) {
        var constraintToChange: NSLayoutConstraint?
        var drinkView: UIView?
        switch player.position {
        case .topLeft:
            constraintToChange = topRightDrinkWidthConstraint
            drinkView = topRightDrinkView
        case .centerLeft:
            constraintToChange = centerRightDrinkWidthConstraint
            drinkView = centerRightDrinkView
        case .bottomLeft:
            constraintToChange = bottomRightDrinkWidthConstraint
            drinkView = bottomRightDrinkView
        case .topRight:
            constraintToChange = topLeftDrinkWidthConstraint
            drinkView = topLeftDrinkView
        case .centerRight:
            constraintToChange = centerLeftDrinkWidthConstraint
            drinkView = centerLeftDrinkView
        case .bottomRight:
            constraintToChange = bottomLeftDrinkWidthConstraint
            drinkView = bottomLeftDrinkView
        }

        if let constraint = constraintToChange, let drinkView = drinkView {
            drinkView.isHidden = false
            constraint.constant = 0
            UIView.animate(withDuration: player.drinkTiming, animations: {
                self.view.layoutSubviews()
            }, completion: { _ in
                constraint.constant = 200
                drinkView.isHidden = true
                completion()
            })
        }
    }
}
